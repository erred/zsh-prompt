# prompt

```
cwd (git) (virtualenv) (time)
(screen) (user@machine)>>
```

http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
```
# For my own and others sanity
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
# terminal codes:
# \e7   => save cursor position
# \e[2A => move cursor 2 lines up
# \e[1G => go to position 1 in terminal
# \e8   => restore cursor position
# \e[K  => clears everything after the cursor on the current line
# \e[2K => clear everything on the current line
```
