
\documentclass{article}
\usepackage{amssymb}
\usepackage{amsmath}

\title{Paxos-like implementions in SDN transactions}
\author{John Smith}
\date{Aprilis 2015}
\begin{document}
   \maketitle
   \textbf{Problem statement:} The main goal of this paper is to achieve more parallelism in SDN. The improvement will concern both message-passing between controllers in \emph{control plane}, and time. Thus, we include the design of a convenient protocol satisfying all above properties. 
\part*{Introduction}    
     Our work bases mainly on two articles \cite{CKLS15} and \cite{DBLP:conf/opodis/TurcuPPR14}. We are going to obtain all this results, firstly, by adding slight changes to the model in \cite{CKLS15} and secondly, by using the adapted version of Paxos abstract \cite{DBLP:conf/opodis/TurcuPPR14}.
    In order to achieve more parallelism in SDN control plane for transactional network updates we will try to relax the constraints concerning histories and their consistency.%more modifications might be added during the work
Furthermore, keeping the algorithm \emph{ReuseTag} at work(quotation needed), we are going to %modify its interface, if needed, pending question
specify its execution, \emph{i.e.}, in Line 4 providing the conflict algorithm's interface. The proofs of their corectness have been done already in, \emph{e.g.}, \cite{Lamport98thepart-time}.% This paper doesn't have to be quoted. Rather the one with EPaxos and the doucmentation with proofs
    % introduce a partial order to deal with the incoming updates. Thus not 
    
    This is in order only to improve the process of installation of new independent policies on switches due to its parallelization. This will be obtained thanks to relaxation of the definition of histories and those relative to it.%To be explained
    
    
 
    \part*{Definitions} 
    \textbf{Inference } After stating some basics. We are introducing some changes to the model. 
    Two operations $op_1$ 
    and $op_2$ will
     \emph{interfere} if the output from
      $op_1 \circ op_{2} \neq op_{2}\circ op_1.$ This means that the outside observer is unable to preceive the difference in both cases. By operation, in this particular case, we would mean the installation of different polices on switches. As the switches on which$\pi_1 and \pi_2 $ are installed do not overlap, it seems natural to see it in this way. \\
       \textbf{Histories} Two histories H and H' are \emph{equivalent} if $\exists \sigma\in \Sigma_{n}: \sigma(H) $ does not interfere with H, and H and H' are equivalent in the sense of \cite{CKLS15}.\\   
    %TO be completed
    We say that two paths aren't \emph{conflicting} if one of the following situations is satisfied:
    \begin{enumerate}
    \item \emph{$path_1$} $\cap$ \emph{$path_2$} = $\emptyset$
    \item $\exists i,j:path_1(i) = path_2(j) $ and $path_1$(end)=$path_2$(end) which means that the paths cross but they have the same endpoint, so we don't care about the trace difference, but we are happy that our packet will finally reach the desired endpoint.
    \end{enumerate}
    The list above is exhaustive, because it covers all the situations then there are some sequence of common swithes used by both packets, or that they cross many times, but finally reach the same port. Otherwise we say that two paths \emph{conflict}.\\
    We say that two policies $\pi_1$ and
     $\pi_2$ \emph{conflict} if
     \emph{dom($\pi_1$)} $\cap$ \emph{dom($\pi$)} $\neq \emptyset$ \underline{and} pr($\pi_1$)=pr($\pi_2$) \underline{and} their paths conflict.
\part*{Algorithms}
Firstly we will describe how to deal with conflicts:
\underline{ALGO:}\textbf{Conflict detector:}
\begin{enumerate}
\item[1:]\textbf{If}(pr($\pi_1$)$\neq$pr($\pi_2$)) \textbf{Then} Return FALSE
\item[2:]\textbf{Else If}(\emph{dom($\pi_1$)}$\cap$\emph{dom($\pi_2$)}=$\emptyset$) \textbf{Then} Return FALSE
\item[3:]\textbf{Else If}(path$_{\pi_1}$ conflicts with path$_{\pi_2}$ \textbf{Then} Return TRUE
\item[4:] \textbf{Else} Return FALSE
\end{enumerate}
The order of this cheching is justified by the policies data structure, which would make it faster.

Now we are going to present different algorithms for the message handling for the controllers.
First algo is promoted automatically to be a leader of the requested policy.\\
\underline{ALGO:}\textbf{Controller } \emph{C} \textbf{on receiving a new policy request} \emph{request($\pi)$} \textbf{from client}

\begin{enumerate}
\item[1:] \textbf{If}($\pi$ conflicts with \emph{alreadyInstalled} or \emph{toBeExecuted}) \textbf{Then} send \emph{notAccepted($\pi$,reason=installed)}
\item[2:]\textbf{If}(\emph{toBeCommitted})\textbf{Then} send \emph{notAccepted($\pi$, reason=commit)}
\item[2:] \textbf{Else} \emph{toBeCommitted}$\leftarrow$ \emph{toBeCommitted}$\cup \lbrace \pi \rbrace$
\item[3:] send to quorum \emph{preAccept($\pi$)}
\end{enumerate}

\textbf{Comment:} We see that we add a field \emph{reason}. It serves to inform the application if it can still continue to propose the rejected policy if \emph{reason=commit}, or it should abandon its tentatives, because the system's policies won't change once they are installed or are going to be executed. The \emph{toBeCommited} set is like a queue and so the new element is somehow the "smallest", or rather the earliest, as we regard it in the sense of time of occurrnece. The order doesn't matter but it helps.\\
\underline{ALGO:}\textbf{For controller } C$_{q}$ \textbf{ from the quorum receiving} \emph{preAccept($\pi$)}

\begin{enumerate}
\item[1:] \textbf{If}($\pi$ conflicts with \emph{toBeCommited}$_{C_{q}} $) \textbf{Then} send \emph{preAccept($\pi$,nack)}
\item[2:]\textbf{Else} \emph{toBeCommitted}$\leftarrow$ \emph{toBeCommitted}$\cup \lbrace \pi \rbrace$
\item[3:]send \emph{preAccept($\pi$,ack)}

\end{enumerate}
\textbf{Comment:} here is the case when we just admit that if there is a conflict between the to politics then automatically abort.\\
\underline{ALGO:}\textbf{Leader of }$\pi$ \textbf{receiving the response}
\begin{enumerate}
\item[1:]\textbf{If}(\$2=ack)\textbf{Then} ackCounter++
\item[2:]\begin{tabbing}
\hspace{0.25cm}\=\kill
  \> \textbf{If}(number of acks$>=$ \emph{quorumSize})\textbf{Then}
\end{tabbing} 
\item[3:]\begin{tabbing}
\hspace{0.5cm}\=\kill
  \> \emph{toBeExecuted}$\leftarrow\lbrace\pi\rbrace\cup$\emph{toBeExecuted}
\end{tabbing} 
\item[4:]\begin{tabbing}
\hspace{0.5cm}\=\kill
  \> toBeCommited$\leftarrow$toBeCommitted-$\lbrace\pi\rbrace$
\end{tabbing} 
\item[5:]\begin{tabbing}
\hspace{0.5cm}\=\kill
  \> send to all \emph{executeAccept(\emph{$\pi$},toBeExecuted)}
\end{tabbing} 
\item[6:]\begin{tabbing}
\hspace{0.25cm}\=\kill
  \> \textbf{Else} ackCounter++
\end{tabbing} 
\item[7:]\textbf{Else}
\item[8:]\begin{tabbing}
\hspace{0.25cm}\=\kill
  \> If(number of acks$>=$ quorumSize) do nothing
\end{tabbing} 
\item[9:]\begin{tabbing}
\hspace{0.25cm}\=\kill
  \> \textbf{Else} notAccepted($\pi$,\emph{reason=commit})//sent to client/application/server
\end{tabbing} 
\item[10:]\begin{tabbing}
\hspace{0.25cm}\=\kill
  \> toBeCommited$\leftarrow$toBeCommitted-$\lbrace\pi\rbrace$
\end{tabbing} 
\item[11:]\begin{tabbing}
\hspace{0.25cm}\=\kill
  \> send to all \emph{Reject($\pi$)}
\end{tabbing} 
\item[12:]\begin{tabbing}
\hspace{0.25cm}\=\kill
  \> send to application \emph{notAccepted($\pi$,reason=commit)}
\end{tabbing} 
\end{enumerate}  
    \part*{Properties}
    All that this simple algorithm guarantees is that if the conflict appears then both policies will be rejected giving the reason. It means that we will get the \emph{consistency} in the sense of \cite{CKLS15}.    
     %TO be completed
\bibliography{bibtex}
\bibliographystyle{plain}

\end{document}
