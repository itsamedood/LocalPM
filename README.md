# **LocalPM**
### Local Password Manager
> # **Installation**
<<<<<<< HEAD
> ## Install the file `Lpm` from the [releases](https://github.com/itsamedood/LocalPM/releases).
>
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
=======
> ### Install [NekoVM](https://nekovm.org/download/), as this is what you need to run the `.n` file.
> ## \***NOTE: This part only works on Linux and MacOS as of right now, but if you can get it to work on Windows, let me know how so I can update this. Sorry for the inconvenience!**
> ### Download the `default.n` file and save it wherever you want. It is recommended that you save it in a folder starting with a `.` as that will make it hidden by default.
> ### Open `~/.zshrc` and add the following line:
> ```zsh
> alias pm="cd path-to-dir-you-saved-default.n-in && neko default.n $1 $2 $3 $4 $5 $6 $7 $8 $9"
> ```
> ### Now run this command:
>>>>>>> c2bb299dcccf78adffb9fd9d1d96697edddb20b6
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
