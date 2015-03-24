---------------
This Readme.txt is from the forked repo at AnthonyMastrean/posh-flow (https://github.com/AnthonyMastrean/posh-flow).
---------------



TOPIC
    posh-flow

SHORT DESCRIPTION
    A PowerShell implementation of the git-flow branching model.

LONG DESCRIPTION
    In January, @nvie[1] introduced a git branching model[2] that's going to blow your mind. He also created git 
    extensions[3] that provide shortcuts for using this model. However, they're shell scripts. That's not a great 
    story for Windows developers. In the meantime, here's a PowerShell version.
    
    The API is bare bones right now. I'm slowly adding features directly from the published model. There's no 
    validation (for example, are you on the develop branch when you start that new feature). I'll scan the comments 
    and the git-flow repo for interesting modifications later. After that, it's all up in the air.

        [1]: http://twitter.com/nvie
        [2]: http://nvie.com/posts/a-successful-git-branching-model
        [3]: https://github.com/nvie/gitflow

USAGE
    Load this module from the default module path ($env:PSModulePath)
    
        Import-Module posh-flow
