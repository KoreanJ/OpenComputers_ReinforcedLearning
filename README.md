# Reinforced Learning Using Minecraft Mod "OpenComputers"
Using a Minecraft modpack, this projects explores the connection between the concepts in Reinforced Learning and empirical statistics. The agent, in this case an in-game "robot", iterates over every state in the small 4x5 game map and attempts to move in every direction 100 times each in an effort to compute the probability of transitioning from one state to another. 
<br>

Once the transition probabilities have been computed, a previously developed reinforced learning algorithm is applied in order to compute the values for each state and in turn compute the most optimal policy. Since the computation time required to compute all of these values in quite long, I only performed a single iteration. 
<br>

In the future I would like to improve this project by putting more of my source code into distributed functions and run more iterations of the algorithm so that I can ensure the most optimal policy is created.
