Sheller
==

A friendly toolbox or Ruby / Shell interactions
-

Sheller offers a unified interface for Ruby interaction with the shell environment and seeks to ease a few common pains.

* Easy access to [STDOUT](http://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29), [STDERR](http://en.wikipedia.org/wiki/Standard_streams#Standard_error_.28stderr.29), and [exit status](http://en.wikipedia.org/wiki/Exit_status#Unix)
* Execution with shell-safe quoting
* Exciting pipe operators
* Shell-safe quotation helpers to use however you like

Don't fumble around with streams
-
    > require 'sheller'
    > Sheller.execute('cat', '/usr/share/dict/propernames').stdout.shuffle[0..5]
     => ["Dennis", "Turkeer", "Ahmed", "Rob", "Spyros", "Mott"]
    
    > Sheller.execute('grep', '*', 'foo').stderr
     => "grep: foo: No such file or directory\n"

    > Sheller.execute('date', '-r', 'ten').exit_status.to_i
     => 256

Automatically sanitize arguments
-
    Sheller.execute('convert',
      attachment.filename,
      '--resize', '10x10',
      thumbnail_filename) 

Pipe and Redirect
-

    Sheller.execute('cal', :|, 'grep', 9)                # Pipe with the symbol :|

    Sheller.execute('echo', 'Frogs', :>, 'frogs.txt')    # Redirect with the symbol :>

Advanced Piping
-

    Sheller.execute('find', '/',
      '-name', filename,
      :'2>&1')

Or use these more recognizable names

    Sheller.execute('find', '/',
      '-name', filename,
      Sheller::STDERR_TO_STDOUT)

Convenient, Shell-oriented Quoting
-

    > Sheller.quote('echo')
    => "'echo'"
    
    > Sheller.quote('~/private/My "so-called" friends')
    => "'~/private/My \"so-called\" friends'"

