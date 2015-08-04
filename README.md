\documentclass{article}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{mathtools}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{perpage}
%\usepackage{fullpage}
 
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
That is why a distributed \emph{control plane} model seems as the most suitable one. When it comes to the \emph{data plane}, we assume that no new switch can join the network and no switch can fail, \emph{i.e.}, the network is \emph{static topologically}. 
  
% interface for the app
The interface we propose for the application is the response of \emph{ack}, if the updated was installed, and \emph{nack}, in case the update was rejected. We also add some information in \emph{reason} field so that which may contain some useful feedback information for the application about the state of the system. It can also be empty. We leave the implementation to the programmers according to the requirements of the system they program.
Thanks to the CPC abstraction we are provided this transactional interface.
%Motivation for this model 

%then be more precise, what are the properties we want to guarantee
% per-packet consistency
Also what we want to provide for the system is that not only the application sees the events performed by the system as sequential but also the traffic is affected by new updates in this manner. This is a so-called \emph{per-packet} consistency property\cite{Reitblatt:2012:ANU:2342356.2342427}. The main idea here is ensure that every packet passing through the network will be delivered only using one global policy. Imagine a packet already beeing in the network and while it has not yet been transported to its destination, there is a new update installed in the whole system. Then we want to guarantee that the given packet will not be affected by this new update and that each new entring packet will follow already this new policy. In other words, a packet is never processed by the mixture of two different policy updates.  
% why the synchronization and where is the problem?
So again, another problem appearing is how to install the updates in order to keep the \emph{per-packet} consistency. Actually, the solution states that the installation should be performed, firstly, on the \emph{internal ports} (not receiving a packet from the outside of the network) and at the end on the \emph{ingress ports} (connected with outside network). In \cite{Reitblatt:2012:ANU:2342356.2342427} the model is designed for one controller but still it applies to multiple controllers set, too.
%Motivation to use this model 
The advantages we gain using this abstract are that  we prevent the occurence of the loops, packet loss and ambiguity in packet delivery. 
Also we obtain invariants for the \emph{traces}\footnote{a \emph{trace} of the packet is, intuitively, a sequence of pairs (\texttt{packet\_modif}, switch), showing the path a packet traveled and the modifications the packet went through} of packets.
%The distributed updates proposed by the applications confronts us with problems like how to consistently 
%Let's now describe more the CPC problem. 
More detailed design's description of the SDN is in section 2. 

%\subsection{Motivation }%for the model}
  
%Motivation for what? for this: research done/domain and then for the research...
\subsection{Contributions}
\subsection{Roadmap}
\section{SDN model and its abstractions}
   Before we will introduce the main problems to tackle in the SDN let's take a brief look on the high-level architecture and new perspectives given by this paradigm.
%High-level overview   with comaprison to the current
% internet construction
The principal idea, as said before, is to decouple the management of the network from the transporting network. In comparison to the current internet model, where it is the task of routers to count the shortest path from itself to each point in a graph via Dijkstra algorithm. When the situation changes, \emph{e.g.}, the delivery cost between two routers changes, new switch joins the graph, or crashes, then at any change, the \emph{flow tables} the routers has must be recalculated via the communication with its neighbours. So on the high-level, each router being linked with other routers, has the software witch provides the calculation of the stated in advance policies like \emph{shortest-path} or others. To influence load balancing  in the network using some outside program would imply a need in changing the whole underlying hardware. In short, the today's network is very rigid, constraint and inflexible for any policy network updates.
That is why there comes a question of how to generalize the 
networks hardware so that it provides more flexibility in 
installing new forwarding updates, and separate the software 
managing the flow. It is the crucial idea for SDN paradigm
 to centralize the management and, thanks to this, enable an
 easier evolution of the system. 
Thus, the SDN model is composed of two independent parts:
 the \emph{data} and \emph{control planes.} Both of them has
different role. 
% Role of the data plane
The first one is for forwarding the packets according to the specified for them policy rules. The specification is for each type of the packet that enters the network. When entering on an \emph{ingress port} it is marked with a \emph{tag}, processed and the actions are applied. The same thing happens on the \emph{internal ports} until a packet reaches the destination. That's the main task of the \emph{data plane.} What makes it evolving\footnote{the evolution here considers only the change of the policies accordingly to the applications' demands. The evolution is here not about the topology, that we stated stable.} it is the \emph{control plane}. In this model we assume to have the switches that are always \emph{correct, i.e.}, they never fail, and that no switch can join the network. The \emph{data plane} is thus said \emph{topoligically stable.}\\
%Possible complications still present
To prevent the reader from thinking that it simplifies the model too much, think, please, about still pending question of synchronization of the control plane and proving the consistency of the system when many concurrent and likely to be conflicting (between themselves or with already installed updates) updates arrive at a time. There are still problems to take into account here.\\
% Role of the control plane 
The control plane receives the update requests from the exterior applications and, if the proposed policy is consistent with already installed one, it installs it and acknowledges the application. If the update is not consistent, it conflicts then the request is rejected and a \emph{nack} is send to the application. \\
% More details about the implementation
As it was already said the \emph{control plane} is, in our case, a distributed, fault-prone, eventually synchronous system consists of the entities called \emph{controllers}. Thanks to the communication between themselves and with switches, they can actually collect the knowledge about the actualisations and perform actions maintaining the corectness of the system. 
%  Motivation for the choice --- maybe not as useful now :)


% intuition of the controller's behaviour
Each controller receives a request from the application(s) and firstly saves in a local memory, then broadcast the information about a new policy to install, and finally searches to save its proposition on the consensus object. As the construction of the system guarantees\footnote{this property will be prooved} that at some point each policy is "considered"\footnote{what does it mean to be considered by an consensus object will become clear in the section about the consensus object's implementation} by the consenus it implies the progress of the system. Once a controller learns it's policy has been considered, and if it has gathered also the information about the content of already linearized policies, it can calculate if the  update can be installed  or not, and, respectively to the result, answer the demanding application.  \\
\subsection{Abstractions for SDN}
% Short presentation
Having already presented some main overview on the model's construction, to make it more tangible and realistic we will present 5 abstractions. Since our model is specific only for the second abstractions, let's forget now the \emph{stable topology} property.
% Short description of each aspect
\begin{enumerate}
\item \emph{Network-wide structures:}
In order to maintain consistent versions of network-wide structures such as topology, traffic statistics and others, one need to process the data from the whole network. In the traditional network vision, all relies on the distributed algorithms acting on the whole network. In general one need many ressources and the main problem is that the switches act in a "blind" way, they can know localy what happens and  to get this information they need to communicate with each other and at any time they recieve the message, they are about to recompute their data and broadcast it in the neighbourhood. \\
In SDN all the knowledge about the state of the entire  system like host locations, link capacities, the traffic matrixes, etc. are stored in \emph{Network Information Base} (NIB). Thus, after same change in the topology of the network, there is a need to recompute some data to maintain the desired structures that keep track of the information, the controllers can reuse the knowledge from NIB. If there is a need for the controllers to communicate with themselves, there is still a necessity to use distributed algorithms. However, the small number of controllers provides faster convergence than in the traditional setting.  
\item \emph{Distributed updates:}
%General description
The SDN \emph{control plane} has to manage the updates on multiple switches in a consistent way so that it would not produce loops, packet's loss or ambigous rules. 
%Comparison with traditional and SDN
In traditional networks the consistency is only eventual. That means that, after a change has occured in the system we only expect that there exists a moment in time since when the system works properly( keeping all the properties). It means that we admit, \emph{e.g.,} that if a switch or link crashes, that during the recovery a packet may traverse the network using partially the policy before and partially the policy after calculation, so the mix of two of them. 
In SDN we expect from the system the \emph{per-packet}, \emph{i.e.,} no packet is processed by the mixture of two global network configurations. 
% Why do we need this stornger version?
The puropse of it is that we want to maintain the invariants such as access control or isolation between the traffic of tenants sharing the network\cite{Casado:2014:ASN:2661061.2661063}.
%What are the challenges for distribution updates
% Why is it necessary?
The distributed updates problem shows more visible in several situations that may possibly happen in the "real-life" networks.
On the high-level, each change in the policy caused by the necessity of quick reaction like a change in the \emph{data plane's} topology, or just a simple modification of the rules, needs a consultation of the current state of the system and a synchronization among controllers to reach an agreement. To coordinate the operations between controllers, provide the correct roll out of the modifications, and finally to when everything is installed to just "turn-on" the updated network requiers some effort.
One of the possible events occuring is when some switch or link crashes, and the \emph{control plane} has to dynamically decide (actually it is the external application which proposes the new update to the control plane) how to reinstall all the network so that there were no rules leading to/by the crashed switch(es)/link(s). 
Other example is when, thanks to the additional knowledge from the \emph{OpenFlow}, we learn that some parts are overloaded with packets. Thus it will be natural for the administrator to balance the load what implies a change in rules.
On the other hand, for theoretical reasons, one might want to search out the best policies' configuration while modifying the flow on different ingress ports and observing the possible behaviour of the network.
Any time we want to avoid loops, packet loss or ambiguity, we need some invariants like \emph{per-packet} consistency to maintain the correctness of the system.
The \emph{per-packet} consistent property will be better explained in the abstraction's section.

%It is the problem we tackle in this paper. 
\item \emph{Modular composition:}
\item \emph{Virtualization:}
\item \emph{Formal verification:}
\end{enumerate}

% Different implementation variants in related works and their advantages and disadvantages
% Different abstractions of SDN and a short description of them
% 
% Motivation
% What can happen if we don't take care of this part
% things to consider like: synchronization, consensus
%
\section{Definitions in the model}
% Short intro motivating the modelisation
To capture and prove the properties we want to obtain leads us to define a formal model of SDN. \\
% Explain why 
% 
\textbf{The control plane} as already described is composed out of at least n$\geq$2 failure-prone controllers. Each controller can communicate with other contorllers, switches and the applications that sollicits it. \\
\textbf{The data plane} we represent as a set of \emph{ports} P and a set of links L $\subseteq P\times P$ as in \cite{Reitblatt:2012:ANU:2342356.2342427}. \\
We distinguish two types of ports. An \emph{ingress} port is when there is link to it from inside the network we are in, but from the outside. Otherwise the port is called \emph{internal}. There are also two specific types of ports $\lbrace \textit{World, Drop}\rbrace$. Every internal port is connected to the \emph{Drop} port, what means it that if a packet does not match any rule, or when it is \emph{filtered} by the network it can be dropped. Some ports are connected to \emph{World} port meaning that they can send it outside of the network we model. We describe the packets as a set $\Pi$.\\
\textbf{Port queues and switch functions} We base here totally on the definitions proposed in the model of \cite{CKLS15}.
The \emph{state} of the network is characterized by a \emph{port
  queue} $Q_i$ and a \emph{switch function} $S_i$ associated with
every port $i$.
A port queue $Q_i$ is a sequence of packets that are, intuitively, waiting to be processed at port $i$.
%\mcnote{The definition of switch function is not very clear to me. I would think that it reads from a queue, processes the packet and places it to another queue. Also, located packet seems like an important concept but it is only introduced in an indirect way.}
A switch function is a map $S_i:\;\Pi\rightarrow \Pi\times P$,
that, intuitively, defines how packets in
the port queue $Q_i$ are to be processed.
When a packet $\textit{pk}$ is fetched from port queue $Q_i$, the corresponding \emph{located
  packet}, \emph{i.e.}, a pair $(\textit{pk}',j)=S_i(\textit{pk})$ is computed and the packet $\textit{pk}'$ is placed to the queue $Q_j$.

We represent the switch function at port $i$, $S_i$, as a collection of \emph{rules}. Operationally, a rule consists of a pattern matching on packet header fields and actions such as forwarding, dropping or modifying the packets. We model a rule $r$ as a partial map $r:\Pi\rightarrow \Pi\times P$ that, for each packet $pk$ in its domain $\textit{dom}(r)$, generates a new located packet $r(pk)=(pk',j)$, which results in $pk'$ put in queue $Q_j$ such that $(i,j)\in L$. Disambiguation between rules that have overlapping domains is achieved through priority levels and also thanks to the paths, as discussed below. We assume that every rule matches on a header field called the \emph{tag}, which therefore identifies which rules apply to a given packet. We also assume that the tag is the only part of a packet that can be modified by a rule.\\
\textbf{Port operations} Each port's state can be read or modified, by adding or deleting the rules, at any time by a controller. This operation is atomic. So again, we base on the model in \cite{CKLS15}, we write formally that a port $i$ supports the operation: $update(i,g)$; where $g$ is a function defined on a set of the rules.
% we add also a formal definition of a bundle
 We will also be using a construction called \emph{bundle}. A \emph{bundle} is a sequence of $update(i,g_j)$ seen as one atomic operation. The differece is on the interface level. A bundle as a set of operations of different kinds, if one of them fails (for example, the function $g_k$ returns false or is "rejected" by a switch), then no operation takes effect on the switch's rules. A controller requesting the bundle is informed about the outcome.\\
\textbf{Paths and policies}
Let's look on the data plane as on the graph. Then when a packet is \emph{forwarded} from the ingress port to the \emph{Drop} or \emph{World} port we see at as a path: $\textit{ingress port} = s_1\rightarrow s_2 \rightarrow\ldots\rightarrow s_k = \text{Drop/World.}$ This definition implies that a path cannot contain loops. A path is \emph{valid} it passes through the existing links. For example, if a port $P_1$ is not connected with $\P_2$ and a path $p_1$ contains both of them, then $p_1$ is not valid. 
We say that two paths aren't \emph{conflicting} if one of the following situations is satisfied:
    \begin{enumerate}
    \item \emph{$path_1$} $\cap$ \emph{$path_2$} = $\emptyset$
    \item $\exists i,j:path_1(i) = path_2(j) $ and $path_1$(end)=$path_2$(end) which means that the paths cross but they have the same \emph{endpoint}, so we don't care about the trace difference, but we are happy that our packet will finally reach the desired endpoint.
    \end{enumerate}
    In practice, the endpoints are stated are known, so during the verifaction a controller can actually decide whether to consider two paths as being in conflict or not.
    The list above is exhaustive, because it covers all the situations when there are some sequence of common ports used by both packets, or that they cross many times, but finally reach the same port. Otherwise we say that two paths \emph{conflict}.\\
    A policy $\pi$ is characterized by domain($_pi)\subseteq\Pi$, a \emph{priority level}, $pr(\pi)\in\mathbb{N}$ and the set of \emph{valid paths}. A new policy update does \underline{not} have to be apply for each ingress ports. It a relaxation of what is in \cite{CKLS15}, where a policy should contain at least one valid path for each ingress port.
    
We say that two policies $\pi_1$ and $\pi_2$ \emph{conflict} if \emph{dom($\pi_1$)} $\cap$ \emph{dom($\pi$)} $\neq \emptyset$ \underline{and} pr($\pi_1$)=pr($\pi_2$) \underline{and} their paths conflict. Otherwise they are called \emph{independent}.
If a packet $pk\in dom(\pi_1) \cap dom(\pi_2)$ and $pr(\pi_1)>pr(\pi_2)$ then $pk$ is processed always by the policy with higher priority. 
If two policies does not conflict we say that they \emph{compose.} So for any update request, we will allow to take place only those which composes with what was installed before. Differently, an update must be rejected.  \\
\textbf{Traffic} Again we use the model from \cite{CKLS15} where the traffic is modeled only using to actions:
\begin{enumerate}
\item \emph{inject(pk,j)} : where the packet $pk$ enters the network at $j^{th}$ ingress port, by being added to the end of the queue $Q_j$ becoming $Q_j.pk$
\item $forward(pk,i,pk',j), j\in P$ : the first element of the queue of the $i^{th}$ port it dequeued from $Q_i$, the actions are applied to $pk$ so that it becomes $pk'$ and it is send through the link to the $j^{th}$ port and enqueued to $Q_j$
\end{enumerate}
Thanks to the traffic events we can now define what is a trace. A \emph{trace} is a sequence generated by a packet entering the network denoted as $\rho_{ev,H}$, where $ev = incject(pk,j)$ in a history H. Note that the sequnce is made of forward events $forward(pk_i,j_i,pk_{i+1},j_{i+1})$, where $pk_0=pk \textit{and} j_0=j$, until $j_{i+1} \in\lbrace World, Drop \rbrace$. Then we say that the trace \emph{terminates}.
We also say that a trace $\rho_{ev,H}$ = $(pk,j),(pk_1,j_1),...$ of $pk$ is \emph{consistent} with a policy $\pi$, if $pk\in dom(\pi)$ and $(j,j_1,...)\in \pi$ \cite{CKLS15}.
\subsection{Concurrency and sequentiality}
Dealing with multiple in some sense independent objects which have a common oprerational area we are faced with a notion of \emph{concurrent object}. A concurrent object is shared by processes. It is equipped with methods each process can invoke. The answer it receives is according to the state of the concurrect object at a time of calling a method. The state of the object after the call (s \emph{side-effect}) is also known.It is specified in a so-called \emph{sequential documentation.} What interests us here is its \emph{correctness} and \emph{progress}. But what does it mean for a concurrent object to be correct or to progress? Everything depends here on object.
In our case, the concurrent object will be the CPC abstraction. Receiving the concurrent requests it has to return a response $ack$ or $nack$ stating for \emph{yes} the update will take place, \emph{no} the update was rejected, respectively. Each action, the request and the response and also the traffic will be seen as sequential while maintaining the \emph{per-packet consistency}.
To be more precise we are obliged to use more fomalisms.
To model the executions and the traffic events we will use \emph{histories}. A history "saves" in its "memory" some considered actions that happend in the system. In our case, the history will be composed of two types of actions: request and  answer to the request (communication between the system and the application), and packet incject events (concerning the traffic). Observe that we are not interested in when will the packet leave the network, but only when it enters.
We will see the history globally (the actions in the whole network set) and locally $H|p_i$ on each controller.
We say that a request $r$ \emph{precedes} $r'$ in a history $H$, $r<_Hr'$, if the invocation and response of $r$ are before the invocation of $r'$. Otherwise, we say that the requests are \emph{concurrent}. For the inject traffic event $ev$ we say that it \emph{precedes} (resp., $succeds$) a request $r$ in history H, $ev<_H r$, if $ev$ appears before invocation (resp., after response)  of $r$ in H. If it appears in between, so we do not have neither $ev\nless r$, nor $r\nless ev$, we say that an event $ev$ is concurrent to $r$. Also, two inject events $ev$ and $ev'$ on the same port in H are related by $ev<_Hev'$, if $ev$ \emph{precedes} $ev'$ \cite{CKLS15}.
We say that a history $H$ is \emph{sequential} if there are no concurrent requests and events. H is \emph{well-formed} if every local controller's history is sequential. Two histories $H$ and $H'$ are equivalent, if for each controller p $H|p = H'|p$. 
An important thing to mention is that we assume that each controller accepts a new request only when the previous one was answered\footnote{the possible implementation would be to put the pending requests in a buffer and only "wake" them up when the response to the previous one appears}. By this, each local history $H|p$ is sequential.
To be able to compare all actions, we need not only the partial order yet introduced, but the total one. We have then to complete the history. A history is \emph{incomplete} if there exits a $p$ such that for $H|p$ a request has not been answered. Otherwise, $H$ is called \emph{complete}. The \emph{completion} of the history is made by adding a response to some request accordigly if it affected a packet (then with an \emph{ack}), or not (then with an \emph{nack}). \\
To justify why it can happen that a history might be incomplete, consider the situation when the requested policy was successfully installed and it is already applied to some packets, but the controller learns it only when receiving a notification from the data plane. \\
Two histories $H and H'$ are \emph{equivalent} (not necessairily completed ones) when their local histories are equal, $H|p=H'|p$ and when for all events $ev$ traces $\rho_{ev,H}=\rho_{ev,H'}$.
A history is said to be \emph{legal} if : the committed (acked) policies are not conflicting and when for every inject event, its trace is consisted with all preceding acked policies \cite{CKLS15}.\\

Now we are ready to define the \emph{sequential compositionality} or, in other words, \emph{linearizibility} of a history. A history $H$ is \emph{sequentially composable} if there exists a legal sequential history $S$:
\begin{enumerate}
\item completion of $H$ is equivalent to S
\item $<_H\subseteq <_S$
\end{enumerate}
There might be many $S$ sets equivalent to $H$. The main idea here is to be able to shuffle/reorder some events in a legal way, to be able to see them as executed atomically. More about this task will be in the CPC section.

\section{Abstractions used}
% Short intro
The distributed choice implies the possiblity to consider the failures and eventual synchrony, what would be useless in the case of just one all-powerfull controller. To make the controller-controller and controller-swich communication realistic and its implementation feasible we need to introduce different assumptions to the model. The abstractions specifies it in more detail.

\subsection{Message-passing}
There are three types of messages. One from outside, and inside two types: controller-controller and controller-switch. We can also discern between \emph{broadcasting} and a \emph{single message}. The former abstraction enables an entity to send a message to "all" from a specified group\footnote{in our case, "all" will refer to controllers, no matter who emits switch or controller} in just one step. The latter will generally concern controller-switch communication. 
We do not state nothing about the messages originating from outside. When they reach a controller it starts processing it. For single messages and broadcast, we use the \emph{Best-Effort Broadcast(BEB)} model as proposed in \cite{Guerraoui:2010:IRD:1951643}. We expect it to be eventually delivered. So after some finite amount of time even if the message was lost even many times it is finally delivered. In the model we propose we could even relax it a bit by saying that at least $f+1$ messages are eventually delivered, where $f$ is the maximal number of faulty controllers. 
%Properties
The BEB has generally three properties:
\begin{enumerate}
\item \emph{Best-effort validity} : if a correct process $p_i$ broadcasts a message m then eventually every correct process $p_j$ receives it
\item \emph{No duplication} : no message is delivered more than once
\item \emph{No creation} : if a message was received by $p_j$ than it was sent by some correct $p_i$
\end{enumerate}
In fact, we do not need the second condition, which reduces the redundancy, but makes the model more simple. 
If a sender crashes then thanks to the failure detector the control plane learns it and one of the correct controllers will take over.
\subsection{Synchronization and Partial synchrony}
Time is one of the most important notions to capture in a real (not just teoretical) distributed systems. On its definition and accuracy of measurement depends, in some sense, the local knowledge of an enitity about the global status in the considered environment. Furthermore, time counting makes the entities to progress even if, \emph{e.g., }the expected message does not arrive.
We are going to use here a physical time to measure.
By \emph{partial} or \emph{eventual synchrony} we mean that \emph{most of the time}, the physical time bounds are respected \cite{Guerraoui:2010:IRD:1951643}. It is an adequate manner of perceiving the distributed systems in practice. We assume only that after some indetermined \emph{a priori} amomunt of time the selected assumptions hold. In some sense, we can regard the system as being synchronous most of the time, and otherwise it turns into an  asynchronous one.
The situations when a time bound is not kept may be caused by, for example, lack of memory on the entity, too much workload, link failure, link congestion.
\subsection{Failure detector}
As the examined parts of the system like controllers risk ot crash, there is a vital need for their peers and for the correctness of the system in general to detect the possible failures. The system being partially synchronous may lead to possible mistakes while examination of the possible failure. This is caused by arbitrairly long, but at the same time bounded, delays.
That is also why the choice of \emph{Eventually Perfect Failure Detector (EPFD)} is the most suitable one. It mainly has two properties after \cite{Guerraoui:2010:IRD:1951643}
\begin{enumerate}
\item \emph{Strong completeness :} eventually, every crashed process is permanently suspected by every correct process
\item  \emph{Eventual Storng accuracy :} eventuall, no correct process is supsected by any correct process
\end{enumerate}
Already, we can observe three different "opinions" a controller might have about its peer $p$: it is \emph{correct, suspect of crashed.} Only the middle term has to be more elaborated. A process $p$ becomes suspect if the \emph{heartbeat} message has not been delivered within an expected time interval. Then $p$ is suspected by $q$, which is awaiting for the news of $p$, as a possibly crashed. A dealayed message can finally arrive and then $q$ revises its knowledge about the situation of $p$ which was false. As a consequence $q$ enlarges the timeout for $p$'s response.  

\subsection{Per-packet consistency}
In this section we would like to present a very important notion to our work of \emph{per-packet} consistency. Before we will state the  definition, let's take a look at an example which will introduce us more into the origins of this abstract.
Imagine we have a SDN network with switches and already defined some rules that guarantee  access control. It means that some packets after reaching a certain switch are simply denied to be forwarded and are dropped. This is also what we have mentioned before as flitering. And now we want to install a new udpate which will change  the security policy to more strict one. It is not difficult to see that a programmer is then faced to install the updates in an order which will not violate the former security policy. As we cannot do it in one atomic step (at least with yet introduced definitions), so the reconfiguration have to be rolled out one-by-one on each switch. So the problem is with which switch to start and which policy should we install on it. It is absolutely not trivial task.
To make it easy programmable we want to enable all new incoming configurations to be verified by the programmer using just a simple function. The main achievement of the \cite{Reitblatt:2012:ANU:2342356.2342427} is to construct an abstract that no matter the order to install new rules, it works. Intuitively, this universal mechanism depends on a \emph{tag} that each packet is stamped with on entering the network at ingress port. This version number characterizes the current network configuration and tells the switch which rules should be applied (those carrying latest version and the highest priority). It does not mean that the older rules are forgotten. During the \emph{two-phase update}, that we are going to describe, they also get the latest version tag and they are used according to their domain and the highest priority as stated.\\
The per-packet consitency provides us with so-called \emph{trace properties} chracterizing the paths that a packet is allowed to take \cite{Reitblatt:2012:ANU:2342356.2342427}. 
% implementation of per-packet consistency
The implementation consists of two main parts : the \emph{one-touch update} and the \emph{unobserval event.} Both constitue what we call a \emph{two-phase update.} 
The \emph{one-touch update} stands for an update that with the property that no packet can take a path through the network that reaches an updated (or to-be-updated) part of the switch rule space more than once \cite{Reitblatt:2012:ANU:2342356.2342427}. In other words, we can see it simply as a loop-free property.
An \emph{unobservable update} is an update that does not affect the set of traces which the packets can produce while traversing the network. It means that if $P$ was the set generated by all types of packets served in the network before the configuration, the after it the set generated by the packets $P'=P.$\\ 
The idea behind it is to firstly install the new rules on the internal ports. For the moment, thanks to the tag they have which is bigger than the current one, the new configuration remains invisible for the packets and so they follow still the former policy. The second step is to install the new rule on the ingress port \underline{and} make it to stamp the incoming packets with the new version tag. Then the new forwarding rules may be safely applied.
%If needed: introduce the formal definitions
\subsection{CPC abstraction}
To talk about the \emph{Consistent Policy Composition (CPC)}, let's firstly have a brief look at it origins coming from \emph{Software Transactional Memory (STM)}\cite{Shavit:1995:STM:224964.224987}. A \emph{transaction} is a finite sequence of operations. To be more specific, a transaction is generally used on shared-memory structures and the operations it concerns are \emph{read-write} ones. A software transactional memory is a shared memory to which we can apply a sequence of operations in one atomic step thanks to the usage of transactions.
The CPC abstraction as its predecessor STM has as a main task to, roughly speaking, order sequentially the incoming concurrent events. More then that the CPC not only addresses to the policies proposed at a time, but also to the traffic. It means that we can see both of them in the history as linearized. To be more formal we say that the CPC problem is solved if for every history $H$, there exists a completion $H'$ satisfying two properties:
\begin{enumerate}
\item \textbf{Consistency:} $H'$ is sequentially composable
\item \textbf{Termination:} eventually, every correct controller p receiving a request answers with \emph{ack} or \emph{nack} in H
\end{enumerate}
From the \emph{sequential compositionality of histories} we will easily deduce the \emph{per-packet consistency.} 
In this paper we implement the $CPC$ abstract using the consensus objects from \emph{universal construction}.
%It also guarantees the \emph{all-or-nothing} semantics, which means that if one of the operations in the sequence  is rejected, then the transaction is rejected, too.
\subsection{Compare And Swap}
\emph{Compare And Swap(old, new)}(CAS) is a very common synchronization operation. It is works as follows: when called it verifies the \emph{register}, a read-write memory location, if has the value equal to $old$. If yes, it overwrites it with new value $new$, otherwise no action is taken and the method returns the value in the register. Other way of specification is to say that if the method has overwirtten the value, it returns $true$. Otherwise it retruns $false$.
When implementing the OpenFlow as in \cite{In-band}, one can use one of the above variants. We will you the one proposed in \cite{In-band}.
\subsection{Consensus Object and Universal construction}
%Set off with a short intro
Before we will describe what the universal construction is about let's have a brief overview on the consensus object. The consensus is a sort of a common agreement between objects about, for example, what value to chose.
The consensus abstraction is characterized with four properties according to \cite{Guerraoui:2010:IRD:1951643}.
\begin{enumerate}
\item \emph{Termination :} every correct process finally decides value
\item \emph{Validity :} the decided value was proposed by some process
\item \emph{Integrity :} the decision is only taken once
\item \emph{Agreement :} every correct process takes the same decision
\end{enumerate}
It is a complete description of what properties we will try to guarantee while refering to the consensus object. The implementation will be presented later.

To continue let's introduce some definitions. A method is \emph{wait-free} if any time it is called, its execution is finished in a finite number of steps. An object is \emph{wait-free} if each method it contains is wait-free. 
To solve a consensus in a wait-free manner is not always possible. However, there exists some classes of objects called \emph{universal}. It means that one can construct a wait-free linearizable implementation of any concurrent object using the objects from this class. It is a powerful generic tool which will help us to implement the CPC abstraction using the consensus objects.  
On the high-level the universal construction serves for solving the consensus in a wait-free manner when no matter how many processes there are. The one we consider here has also the special property which is that at some point any value will be present in some consensus object.
Each process possesses its local variables: $prod,k\in\mathbb{N}$, where $prod$ is the number of values proposed by the process and $k$ the latest consensus instance used; $linearized=(v_1,r_{i_1},id_1,prod_1),(v_2,r_{i_2},id_2,prod_2),...,$ where $v_k$ stands for the agreed on value, and  $r_{i_k}$ is the round number and the $id$ number for the idendtifier of the demanding process and $prod$ is the number of values, set initially to zero, a given process has yet proposed\footnote{ remark that there can be more then one decided value for each round; secondly, we can and will add more fields for each element on the list in the exact implementation, but now for the reasons of simplicity we leave it in this form}, the list is storing already decided by all processes former values; $toBeLinearized = (v_1,id_1),(v_2,id_2),\ldots$, a list storing the values proposed by other processes, but still waiting to be agreed on. By $C[k]$ we mean the $k^{th}$ consensus object's instance. The algorithm for each process $p_i$ proposing some value to be chosen:
\begin{enumerate}
\item add $(v_k,id_{p_i})$ to $toBeLinearized$
\item $toBeLinearized$ = $toBeLinearized - Linearized$\footnote{here we abuse a bit the notation, because the elements of both lists has some different fields. However, we can identify the same elements on both lists thanks to the process' $id$, the proposed value and the $prod$ field}
\item send to all $(linearized, toBeLinearized,k)$
\item repeat
\item $response$ = C[++k].propose($toBeLinearized$)
\item $linearized$ = $responses.linearized$
\item until C[k] returns \texttt{Success}\footnote{what happens when the proposed value(s) in $toBeLinearized$ won the consensus} 
\item $++prod$
\end{enumerate}

Brievely, when the process proposes a value it checks what are the already linearized ones and which to propose. It sends also its list to all processes to make them aware about the change in the system. The thing is that it does not have to await them to answer, but dierctly sends its proposition to some instance of the consensus object. It resends it to the following instances until, either it or other process has put this proposition in some object. The latter can happen thanks to the Line 3, when other processes learn about the new request. 
\section{Interfaces}
%
\subsection{Message-passing}
\subsection{Failure detectors}
\subsection{CPC abstraction}
\subsection{Universal construction}
%
\section{OpenFlow 1.4.}
% Motivate the OpenFlow utility
The \emph{OpenFlow}, that we are going to describe a bit more in the special section, is the specification we use for the switch and a communication protocol between switches and controllers. To get a simpler and clearer vision of this model we propose a more mathematical approach to describe it.  
% Try to describe the features it has and that you use in this paper

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
\section{Conclusion}
\bibliographystyle{plain}
\bibliography{bibtex}

\end{document}
