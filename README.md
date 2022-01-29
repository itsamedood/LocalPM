# ***Password Manager***
> # **Installation**
> ### Install [NekoVM](https://nekovm.org/download/), as this is what you need to run the `.n` file.
> ## \***NOTE: This part only works on Linux and MacOS as of right now, but if you can get it to work on Windows, let me know how so I can update this. Sorry for the inconvenience!**
> ### Download the `default.n` file and save it wherever you want. It is recommended that you save it in a folder starting with a `.` as that will make it hidden by default.
> ### Open `~/.zshrc` and add the following line:
> ```zsh
> alias pm="cd path-to-dir-you-saved-default.n-in && neko default.n $1 $2 $3 $4 $5 $6 $7 $8 $9"
> ```
> ### Now run this command:
> ```
> pm setup
> ```
> ### And just like that, you're good to go! Run `pm help` for all commands :)
> ---
