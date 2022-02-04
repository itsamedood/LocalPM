# **LocalPM**
### Local Password Manager
> # **Installation**
> ## Install the file `Lpm` from the [releases](https://github.com/itsamedood/LocalPM/releases). Now follow the steps below depending on your OS.
> ---
> # **Windows**
> ### Oops! This program doesn't work on Windows... yet!
> ---
> # **MacOS**
> ### Move the file you downloaded wherever you want. Keep in mind that once you put it somewhere, it will have to stay unless you update `.zshrc` every time you move it. I recommend putting it in your `Documents` folder, but you may put it wherever you wish.
> ### Open Finder and go to `Home` and open `.zshrc` (you will need to be able to see hidden files to do this.)
> ### Go to the bottom and add the following line:
> ```zsh
> # Assuming you saved your file in `~/Documents`
> alias lpm="~/Documents/Lpm $1 $2 $3 $4 $5 $6 $7 $8 $9"
> ```
> ### Run the following command:
> ```txt
> lpm setup
> ```
> ### Now you're good to go! Run `lpm help` for a list of commands and more information!
> ---
> # **Linux**
> ### Move the file you downloaded wherever you want. Keep in mind that once you put it somewhere, it will have to stay unless you update `.zshrc` every time you move it. I recommend putting it in your `Documents` folder, but you may put it wherever you wish.
> ### Open your file manager and go to `/home/you` (you is whatever your username is) and open `.zshrc` (you will need to be able to see hidden files to do this.)
> ### Go to the bottom and add the following line:
> ```zsh
> # Assuming you saved your file in `~/Documents`
> alias lpm="~/Documents/Lpm $1 $2 $3 $4 $5 $6 $7 $8 $9"
> ```
> ### Run the following command:
> ```txt
> lpm setup
> ```
> ### Now you're good to go! Run `lpm help` for a list of commands and more information!
