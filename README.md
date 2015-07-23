\documentclass{article}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{mathtools}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{perpage} 
\MakePerPage{footnote}
\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}

\title{Synchronization and Concurrency in Software-Defined Networking}
\author{Jan Celmer}
\date{\today}
\begin{document}
\maketitle

\subsection*{Abstract} Software-Defined Networking (SDN) is a new design of network architecture. The key idea is to separate  the network management \emph{control plane} from the switches, \emph{data plane}, which take care of the delivery of packets, and logically centralize it.    \\
This construction enables easier management of the updates of the system. 
\\
There are different models of SDN yet proposed. In this case, we have adopted a distributed \emph{control plane} made of a number of entities called \emph{controllers}. This choice is justified, because if there was only one all-powerful controller it might fail at some moment and the system with it. When model involves a set of independent controllers we have more robustness if several of them fails.
\\
One of the challenges to face in SDN is to find consistent mechanisms for installing updates on the \emph{data plane} coming from the applications. This is a so-called \emph{concurrent policy composition}, the CPC problem, where \emph{policy}, roughly speaking, is set of recipes for the \emph{data plane} how to modify and where to forward incoming packets. The problem becomes not trivial when there are many concurrent update requests that \emph{conflict}. Synchronization on the \emph{control plane} is then necessary to solve the CPC problem. 
\\
 The solution of the \emph{CPC problem} proposed in this paper entails the use of \emph{consensus objects} , to guarantee the common agreement of what will and what will not be installed. Roughly speaking, the \emph{consensus objects} provide the linear order on the proposed updates. For communication in the \emph{control and data planes} we use the \emph{OpenFlow 1.4.} standard.
\section{Introduction}
%Let's now expand a bit the description of SDN challenge we face and the model we are placed in. 
\subsection{ SDN update challenge}
%high-level description
The SDN paradigm simplifies the network management and makes easier any software change without need to change the hardware. The easy programmability of the switches is one of best fruits of the SDN. It is achieved thanks to the separation of the \emph{data and control planes}. The logical centralization of the \emph{control plane} is fundamental to this paradigm. 
% Possible models high-level implementaition of SDN
This opens opportunities of implmentations of each part in SDN starting with the \emph{data and control planes}.
% Our model assumptions
In this paper we assume 
% High-level research topics
There are five main abstractions to make the vision of SDN more realisitic\cite{Casado:2014:ASN:2661061.2661063} . In this paper we deal with distributed updates the other will be presented in section 2.\\ 
Faced with concurrent requests, \emph{i.e.,} demands of installation of new policy updates on the \emph{data plane}  from the applications, the \emph{control plane} has to dynamically decide which updates are consistent with already installed policies.
\subsection{Problem statement}
% Informal pb statement
The problem considered in this paper is to find a protocole for the \emph{control} and \emph{data planes} that would guarantee the installation of non-conflicting network policies on the \emph{data plane}. 
\subsection{High-level intuitive model used}
% Rough model
As it was already said the SDN is split in two different independent parts. One of important tasks is to find the implementations of the model which will be robust against the failures, simple, providing high performance of the system in terms of correctness, enabling fast and correct policy update implementation.
That is why a distributed \emph{control plane} moded seems as the most suitable. When it comes to the \emph{data plane}, we assume that no new switch can join the network and no switch can fail, \emph{i.e.}, the network is \emph{topologically static}. 
  
% interface for the app
The interface we propose for the application is the response of \emph{ack}, if the updated was installed, and \emph{nack}, in case the update was rejected. We also add some information in \emph{reason} field so that which may contain some useful feedback information for the application about the state of the system. It can also be empty. We leave the implementaition to the programmers according to the requirements of the system they program.
Thanks to the CPC abstraction we are provided this transactional interface.
%Motivation for this model 

%then be more precise, what are the properties we want to guarantee
% per-packet consistency
Also what we want to provide for the system is that not only the application sees the events performed by the system as sequential but also the traffic is affected by new updates in this manner. This is a so-called \emph{per-packet} consistency property\cite{Reitblatt:2012:ANU:2342356.2342427}. The main idea here is ensure that every packet passing through the network will be delivered only by one global policy. Imagine a packet already beeing in the network and while it has not yet been transported to its destination there is a new update installed in the whole system. Then we want to guarantee that the given packet will not be affected by this new update and that each new entring packet will follow already this new policy. The packet is never processed by the mixture of two different policy updates.  
% why the synchronization and where is the problem?
So again another problem appearing is how to install the updates in order to keep the \emph{per-packet} consistency. Actually, the solution states that the installation should be performed firstly on the \emph{internal ports} (not receiving a packet from the outside of the network) and at the end on the \emph{ingress ports} (connected with outside network). In \cite{Reitblatt:2012:ANU:2342356.2342427} the model is designed for one controller but still it applies to multiple controllers set.
%Motivation to use this model 
The advantages we gain using this abstract are that  we prevent the occurence of the loops, packet loss and ambiguity in packet delivery. 
%The distributed updates proposed by the applications confronts us with problems like how to consistently 
%Let's now describe more the CPC problem. 

More detailed design's description of the SDN is in section 2. 

%\subsection{Motivation }%for the model}
  
%Motivation for what? for this: research done/domain and then for the research...
\subsection{Contributions}

\section{SDN model and its abstractions}
   Before we will introduce the main problems to tackle in the SDN let's take a brief look on the high-level architecture and new perspectives given by this paradigm.
%High-level overview   with comaprison to the current
% internet construction
The principal idea, as said before, is to decouple the management of the network from the transporting network. In comparison to the current internet model, where it is the task of routers to count the shortest path from itself to each point in a graph via Dijkstra algorithm. When the situation changes, \emph{e.g.}, the delivery cost between two routers changes, new switch joins the graph, or crashes, then at any change, the \emph{flow tables} the routers has must be recalculated via the communication with its neighbours. So on the high-level, each router being linked with other routers, has the software witch provides the calculation of the stated in advance policies like \emph{shortest-path} or others. To influence load balancing  in the network using some outside program would imply a need in changing the whole underlying hardware. In short, the today's network is very rigid, constraint and inflexible for any policy network updates.
That is why there comes a question of how to generalize the networks hardware so that it provides more flexibility in installing new forwarding updates, and separate the software managing the flow. It is the crucial idea for SDN paradigm to centralize the management and, thanks to this, enable an easier evolution of the system. 
Thus, the SDN model is composed of two independent parts: the \emph{data} and \emph{control planes.} Both of them has different role. 
% Role of the data plane
The first one is for forwarding the packets according to the specified for them policy rules. The specification is for each type of the packet that enters the network. When entering on an \emph{ingress port} it is marked with a \emph{tag}, processed and the actions are applied. The same thing happens on the \emph{internal ports} until a packet reaches the destination. That's the main task of the \emph{data plane.} What makes it evolving\footnote{the evolution here considers only the change of the policies accordingly to the applications' demands. The evolution is here not about the topology, that we stated stable.} it is the \emph{control plane}. In this model we assume to have the switches that are always \emph{correct, i.e.}, they never fail, and that no switch can join the network. The \emph{data plane} is thus said \emph{topoligically stable.}\\
%Possible complications still present
To prevent the reader from thinking that it simplifies the model too much, think, please, about still pending question of synchronization of the control plane and proving the consistency of the system when many concurrent and likely to be conflicting (between themselves or with already installed updates) updates arrive at a time. There are still problems to take into account here.\\
% Role of the control plane 
The control plane receives the update requests from the exterior applications and, if the proposed policy is consistent with already installed one, it installs it and acknowledges the application. If the update is not consistent, it conflicts then the request is rejected and a \emph{nack} is send to the application. \\
% More details about the implementation
As it was already said the \emph{control plane} is, in our case, a distributed, fault-prone, asynchronous system consists of the entities called \emph{controllers}. Thanks to the communication between themselves and with switches, they can actually collect the knowledge about the actualisations and perform actions maintaining the corectness of the system. 
%  Motivation for the choice --- maybe not as useful now :)


% intuition of the controller's behaviour
Each controller receives a request from the application(s) and firstly saves in a local memory, then broadcast the information about a new policy to install, and finally searches to save its proposition on the consensus object. As the construction of the system guarantees\footnote{this property will be prooved} that at some point each policy is "considered"\footnote{what does it mean to be considered by an consensus object will become clear in the section about the consensus object's implementation} by the consenus it implies the progress of the system. Once a controller learns it's policy has been considered, and if it has gathered also the information about the content of already linearized policies, it can calculate if it can install its update or not and respectively to the result answer the demanding application.  \\
\subsection{Abstracts}



% Different implementation variants in related works and their advantages and disadvantages
% Different abstractions of SDN and a short description of them
% 

\section{Distributed updates in SDN}
% Motivation
% What can happen if we don't take care of this part
% things to consider like: synchronization, consensus
%
\section{Definitions in the model}
% 
% 
\section{Abstractions used}
% Short intro
The distributed choice implies the possiblity now to consider the failures and asynchrony, what would be useless in the case of just one all-powerfull controller. To make the controller-controller and controller-swich communication realistic and its implementation feasible we need to introduce different assumptions to the model.

\subsection{Message-passing}
\subsection{Failure detectors}
\subsection{Synchronization}
\subsection{CPC abstraction}
\subsection{Universal construction}
%
\section{Interfaces}
%
\subsection{Message-passing}
\subsection{Failure detectors}
\subsection{CPC abstraction}
\subsection{Universal construction}
%
\section{Algorithms}
%
%
\section{Pseudocode}
%Write a plain pseudocode
% show methods + which models they use + short analysis of 
%  -high-level algorithm for policy serilaization, based on the iniversal construction using consensus objects
%
An algorithm serializing policies for each controller receiveing a request
\begin{enumerate}
\item add request to the list \emph{notLinearized}
\item broadcast( \emph{notLinearized, linearized}, k)
\item to the \emph{data plane} to C[k+1] send(\emph{notLinearized})
\item wait for the response from C[k'] \footnote{ we'll implement later what does the C[k+1] if it was already used for a different consensus}
\end{enumerate}
%
%- an implementation of consensus in Openflow

%
\subsection{Consensus object implementation}
How then to implement a \emph{consenus object} in \emph{OpenFlow} ? \\
For each switch, for this model we impose that there were at least two \emph{flow tables}. The enumeration of the \emph{flow tables} starts with zero. Depending on the system requierements we cas set on each switch k \emph{flow tables} where we will put the consensus objects. For simplicity we assume here two things. \emph{Firstly,} on each switch there is the same number of \emph{consensus objects.} Remark that we can easily avoid this assumption by the primitive which informs the \emph{control plane} about the number of consensus object/ the total number of consensus objects in this switch. This can easily be done using the \emph{OpenFlow} protocol controller-to-switch messages of type \textbf{Read-state}. It is for the reasons of simplicity we omit this case. \emph{Secondly,} we assume that once all of the \emph{consensus objects} are full, the system informs about it the \emph{control plane} which:
\begin{enumerate}
\item stores all the requests received in the meantime in a buffer or local memory
\item each controller sends a bundle message requesting the deletion of rules in \emph{flow tables} being implemented as a \emph{consensus} object\footnote{so as not to broadcast the message in a total disorder there are two ways of implementation:
\begin{enumerate}
\item only one controller takes care of it and once it finishes, it broadcast a message in the \emph{control plane} about the termination of "cleaning"
\item each controller has some predefined group of switches to "clean" and once it finishes it broadcasts the termination message
\end{enumerate}
In both cases, if a contorller goes down, thanks to the \emph{failure detector} the switch with \emph{id+1 mod n}, where n is the number of controllers ,takes over this task . 
}
\item restarts only when all correct contorllers learns about the "cleaning" in the \emph{data plane}. 
\end{enumerate}
Now we can describe the implementation of the \emph{consensus objects} on the \emph{data plane}. On each switch the \emph{consenus objects} are implemented in tables from 0 to k-1.
\begin{enumerate}
\item for tables 0 to k-1 do
\item Match field $\leftarrow$ ANY
\item priority $\leftarrow \infty$
\item Instructions $\leftarrow$ Goto-Table k
\item end for
\end{enumerate}
First remark is the fields: \emph{counters, timeouts} and \emph{cookies} are set to default values. In fact we won't use them, but all we need is to define correctly according to the \emph{OpenFlow} specification. Secondly, let's explain the choice of the parameters. The \emph{match field} is matched against a packet. If the packet matches the flow entry, the highest priority is chosen and the prescribed instructions and actions take effect at the and of pipeline processing. In our case, we wildcard the packets, it means that the \emph{match field} matches each packet. The priority is set to $\infty$, because otherwise, when the consenus object is filled with new updates, then there might exits a priority greater then we specify by default for the table. It would mean that if there comes a packet matching to both flow entries (the deafault one and the second one with higher priority), then a packet would be processed by this policy violating the \emph{per-packet} consitency property. We think that programming the $\infty$ value would not cause any problems. 
%those talbes, or rather their \emph{flow entries} would be considered as \emph{table-miss} entries. In general, \emph{table-miss} flow entires specifies how to process the unmatched packets by any other flow entries before. And it matches ANY packet and its priority is set to 0. It also contains different features then other flow entires\footnote{for more detailed description ref. \emph{OpenFlow} spec}. All the tables are filled out in the same manner for simplicity. When we will use the \emph{compare(addr,old)} abstract to implement the CAS on them, so as to set the \emph{old}, \emph{i.e.}, the expected value of the flow entry with those data.
\\
Now as we see, the above defined tables will serve for \emph{consensus objects}. The \emph{Goto-Table} instruction guarantees that no packet will be affected by the update rules contained in those tables.
% explain in more details how the consensus object works
Firstly a controller creates a bundle with its specific id, wraps the operations to perform and ends with a commit message. After pre-validating a bundle so as to avoid most of the errors it sends it to a given \emph{consensus object.} How is constructed our bundle? The operations it contains are the following: $\lbrace$ \emph{CAS(addr, old, new), write(addr$_1$, k$_1$), ..., write(addr$_m$, k$_m$)} $\rbrace$. The \emph{write} operations will contain all the update rules specified by the demanded update. To keep a desired order we impose that the 
\emph{write(addr$_l{_{i_1}}$, k$_{l_{i_1}}$)} to 
s\emph{write(addr$_{l_{i_j}}$, k$_{l_{i_j}}$)} contains only the rules form the i$^{th}$ policy update.
  
%- an algorithm for installing updates: what a controller does once it linearized some requests.
%

At the begining when each controller establishes a connection with each switch in the \emph{data plane} it sets a \emph{flow monitor} on the consensus object flow tables. The \emph{flow monitor} serves to call a contorller about the change in a consensus object's content, so in its flow table. It is possible that the communication band is overloaded, in reality, but the OpenFlow already knows how to acknowledge the contorllers. On the other hand, we also dispose of the communication between the controllers, so that even in case of congestion on the bandwidth between the two \emph{planes} the common knowledge about the consensus object's state is "alive", can be verified. 
 By this mechanism each contorller would get to know with more accuracy the first free consensus object's number. 
When the switch using responds for the \emph{bundle} implementing CAS, then the controller taking care of the installation of the requested policy using the \emph{OpenFlow} protocol. \\
Now we are ready to see the what does the controller once it has learned about the \emph{linearized} set from the consensus objects from 0 to some $k'$, where the controller's request is in come C[k] with k$<k'$:
\begin{enumerate}
\item inst $\leftarrow$ \emph{count(linearized, request)}
\item if inst = true then
\item $\forall$ s, switch concerned by the update send \emph{installationRequest(rules(s)})
\item else send \emph{nack(request, reason)} to the application
\end{enumerate}
% --count description
The elements of the list should have the following structure:
struct \texttt{elem\_list}$\lbrace$
\begin{enumerate}
\item int instSucceded;
\item int id;
\item policy pu;
\item boolean inst;
\item int consObjNb;
\end{enumerate}
$\rbrace ;$\\
For the reasons of the specific software demands the \texttt{elem\_list} can contain other fields, but those three are mandatory.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define policy structure!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

count(\texttt{elem\_list}[] list,\texttt{elem\_list} element)
\emph{installed} is a list of \texttt{elem\_list}
\begin{enumerate}
\item installed = $\emptyset$ 
\item if element $\in$ list then
\item k $\leftarrow$ take index of element in the list
\item for i in 0 to k do
\item  if list[i].inst = false then
\item \begin{tabbing}
\hspace{0.25 cm}\=\kill
  \> if compose(installed, list[i]) then \\
  \> list[i].instSucceded ++\\
  \> list[i].inst = true\\
  \> installed.append(list[i])\\
  \> end if    
\end{tabbing}
\item  if element $\in$ installed then 
\item  return
\item  else return false
\item  end if
\item end for 
\end{enumerate}
Remark the \emph{list} is sorted according to the \emph{lexicographical order} defined for policies contained in \emph{consensus objects.} \\
%count description--
%--compose description
compose(\texttt{elem\_list}[] installed,\texttt{elem\_list} policy):
\begin{enumerate}
\item if policy conflicts\footnote{the conflict's definition is in chapter definitions. The implementation is according to the criteria found there.} with installed then return false
\item else return true
\end{enumerate} 
%compose description--
\section{Proofs of the algorithms}
%
%

\bibliographystyle{plain}
\bibliography{bibtex}

\end{document}
