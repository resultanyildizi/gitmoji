# Gitmoji plugin

Gitmoji is a ZSH plugin that generates random Github emojis.

# Quick Start
To use it, clone this repository under your custom plugins.

```console
cd  $ZSH/custom/plugins
git clone https://github.com/resultanyildizi/gitmoji 
```

Then, add gitmoji to the plugins array in your zshrc file:

```
plugins=(... gitmoji)
```

# Usage

This tool enables you to generate a random GitHub emoji or effortlessly add a random GitHub emoji at the beginning of your message.

```console
$ gitmoji
:+1:
$ gitmoji Hi
:sun_with_face: Hi
$ gitmoji "This is a long message"
:black_cat: This is a long message
```
Additionally, it provides the convenience of creating a git commit with a random GitHub emoji using the `gcamj` alias.

```console
$ gcamj "Initial commit"
[main 6e2ad9c] :notes: Initial
 1 file changed, 32 insertions(+)
```
