Sheller
==

A unified interface for Ruby / Shell interactions
--

Sheller offers a unified interface for Ruby interaction with the shell environment.
It provides utilities for quoting arguments to shell commands, invoking commands, returning the output of
the STDOUT and STDERR streams, and process exit codes

    Sheller.execute('convert',
      'image1.png', '--resize', '10x10', 'image2.png')
    
    Sheller.execute('echo', 'Frogs', :>, 'frogs.txt')
