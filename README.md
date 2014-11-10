Racket
======

Turtle
------
In preparation of the turtle system's use please download the file <tt>racketturtle.rkt</tt> and save it in your current working directory.
Create a new file, copy and paste the code below to the very beginning of that file, and subsequently save it.
<pre><code>#lang racket
(require "racketturtle.rkt")
(define width 800)   ; determines the window’s size (turtles’ playground)
(define height 800)
(define dc (start width height))

(define bobby (new turtle%
                    [tname ’Bob]
                    [xpos 400][ypos 500][direction 90]
                    [tcolor "YellowGreen"]
                    [tdc dc]))

(send bobby show!)</code></pre>
Now you are ready to develop your procedures.
The commands an arbitrary turtle understands are shown below. 
Syntactically, each turtle instruction matches the following pattern: <pre><code>(send &lt;turtle&gt; &lt;command&gt; [&lt;parameter&gt;])</code></pre>
<table>
    <tr><td><b>Command</b></td> <td><b>The command's meaning</b></td>
    <tr><td>say-your-name</td><td>displays the full name of the turtle as initially given.</td>  </tr>
    <tr><td>show!</td><td>shows the turtle at the current position.</td>  </tr>
    <tr><td>hide!</td><td>The turtle disappears (from our sight only).</td>  </tr>
    <tr><td>crow</td><td>The turtle crows which sounds like wringing a bell.</td>  </tr>
    <tr><td>sleep <em>n</em></td><td>The turtle sleeps for <em>n</em> milliseconds.</td>  </tr>
    <tr><td>forward! <em>n</em></td><td>The turtle moves <em>n</em> steps following the current viewing direction.</td>  </tr>
    <tr><td>backward! <em>n</em></td><td>The turtle moves <em>n</em> steps back following the opposite viewing direction.</td>  </tr>
    <tr><td>right! <em>n</em></td><td>The turtle turns to the right by an angle of <em>n</em> degree.</td>  </tr>
    <tr><td>left! <em>n</em></td><td>The turtle turns to the left by an angle of <em>n</em> degree.</td>  </tr>
    <tr><td>pen-up!</td><td>causes the turtle to stop tracing beginning at the current position.</td>  </tr>
    <tr><td>pen-down!</td><td>causes the turtle to continue tracing beginning at the current position.</td>  </tr>
    <tr><td>pen-erase!</td><td>substitutes an eraser for the turtle's pen.</td>  </tr>
    <tr><td>set-turtle-color! <em>c</em></td><td>changes the turtle's color to <em>c</em>; <a href="http://docs.racket-lang.org/draw/color-database___.html?q=the-color-database">possible values for <em>c</em></a>.</td>  </tr>
    <tr><td>set-pen-color! <em>c</em></td><td>changes the turtle's pen color to <em>c</em>; <a href="http://docs.racket-lang.org/draw/color-database___.html?q=the-color-database">possible values for <em>c</em></a>.</td>  </tr>
    <tr><td>clone</td><td>creates a clone of the turtle.</td>  </tr>
</table>
See some examples in <tt>racketturtle-examples.rkt</tt>.
