# EasyTiles
Create dynamic tiles in Business Central

This is an experiment to create a dynamic tile solution based on standard building block. The goal is to be as close to AL as possible.

Let’s have a look at the main objectives:

-   Give the users the option to add and remove tiles without any code.
-   The tiles need to mimic the standard function: display a count / sum and open a drilldown.
-   Add the option to run objects.
-   Different tile groups per role centre

Nice to haves:

-   Conditional formatting like in some standard cue groups
-   Change static background colour
-   Show/Hide numeric value
-   Display a custom Icon

Design

Because this is an experiment I couldn’t and didn’t want to implement a full custom tile engine and there are products for that anyway. So here are the principals:

-   5 group of tiles per Role Centre
-   20 tiles per group in configuration of 2x10 or 4x5

I choose the 20 tiles as a limit because it seemed enough to display any role related lists, drilldowns and additional function shortcuts.

<img width="790" alt="image" src="https://user-images.githubusercontent.com/64136814/236013723-a4ab416a-caa9-4c82-8fcb-9b339bb3e2a0.png">

If this wouldn’t be enough it is easy to add more groups to the role centre page and to the configuration.

Challenges

-   Role Centre pages don’t run code: how can I remove the unassigned tile groups
-   Edit the group captions
-   Edit the tile itself: colour, hide counter, add icon

Sounds like we need a control-addin to overcome the challenges. Well, I’m first and foremost an AL guy so JavaScript, CSS and advanced html dom is really not my cup of tea. So the code in the add-ins going to be rudimentary at best but they do the job and hopefully in an understandable manner. No fancy code there for sure!

That concludes the introduction in the follow-up I’ll explain what did I do and why…
