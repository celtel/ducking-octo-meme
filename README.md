# ducking-octo-meme

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
       \textbf{Histories} Two histories H and H' are \emph{equivalent} if $\exists \sigma\in \Sigma_{n}: \sigma(H) $ does not interfere with H, and H and H' are equivalent in the sense of \cite{CKLS15}.   
    %TO be completed
    \part*{Protocole}
    %TO be completed
    \part*{Proofs of properties}   
     %TO be completed
\bibliography{biblio}
\bibliographystyle{plain}

\end{document}
