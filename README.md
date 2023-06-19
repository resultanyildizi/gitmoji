# Gitmoji plugin

Gitmoji is a ZSH plugin that generates random Github emojis.

# Quick Start
To use it, clone this repository under your custom plugins

```console
cd  $ZSH/custom/plugins
git clone https://github.com/resultanyildizi/gitmoji 
```

Then, add gitmoji to the plugins array in your zshrc file:

```
plugins=(... gitmoji)
```

# Usage

You can use it to generate a random GitHub emoji or add a random Github emoji in front of a message 

```console
$ gitmoji
:+1:
$ gitmoji Hi
:sun_with_face: Hi
$ gitmoji "This is a long message"
:black_cat: This is a long message
```
You also create a git commit with a 

