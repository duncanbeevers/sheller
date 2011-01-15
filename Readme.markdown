Sheller
==

A unified interface for Ruby / Shell interactions
-

Sheller offers a unified interface for Ruby interaction with the shell environment.
It provides utilities for quoting arguments to shell commands, invoking commands, returning the output of the STDOUT and STDERR streams, and process exit codes

    Sheller.execute('convert',
      attachment.filename,
      '--resize', '10x10',
      thumbnail_filename)

Pipe and Redirect
-

    Sheller.execute('echo', 'Frogs', :>, 'frogs.txt')
    
    Sheller.execute('cal', :|, 'grep', 9)

Advanced Piping
--

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

