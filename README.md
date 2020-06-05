# My dotfiles

## Installation

Clone this repo and use [make](https://www.gnu.org/software/make/) or
[stow](https://www.gnu.org/software/stow/) to install:

```bash
# Install everything
$ make install

# or install just a few components
$ stow git
$ stow nvim
$ stow kitty
```

## Screenshots

![screenshot-1](screenshots/1.png)
![screenshot-2](screenshots/2.png)
![screenshot-3](screenshots/3.png)
![screenshot-4](screenshots/4.png)
![screenshot-5](screenshots/5.png)
![screenshot-6](screenshots/6.png)
![screenshot-7](screenshots/7.png)
![screenshot-8](screenshots/8.png)

## Keyboard layout

Below is the adjusted keyboard layout that I'm using:

- `caps_lock` is `control` on held, `esc` on tapped
- `return` is `control` on held, `enter` on tapped
- `right_command` and `right_option` is `delete`

[![layout](karabiner/apple_keyboard.png)][1]

[1]: http://www.keyboard-layout-editor.com/##@_backcolor=%23dbdbdb&name=Apple%20Wireless%20Keyboard&author=Alistair%20Calder&radii=6px%206px%2012px%2012px%20%2F%2F%2018px%2018px%2012px%2012px&css=%2F@import%20url(http%2F:%2F%2F%2F%2Ffonts.googleapis.com%2F%2Fcss%3Ffamily%2F=Varela+Round)%2F%3B%0A%0A%23keyboard-bg%20%7B%20%0A%20%20%20%20background-image%2F:%20linear-gradient(to%20bottom,%20rgba(0,0,0,0.5)%200%25,%20rgba(0,0,0,0)%204%25,%20rgba(255,255,255,0.3)%206%25,%20rgba(0,0,0,0)%2010%25),%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20linear-gradient(to%20right,%20rgba(0,0,0,0.1)%200%25,%20rgba(0,0,0,0)%20100%25)%20!important%2F%3B%20%0A%7D%0A%0A.keylabel%20%7B%0A%20%20%20%20font-family%2F:%20'volkswagen%2F_serialregular'%2F%3B%0A%7D%0A%0A%2F%2F*%20Strangely,%20%22Volkswagen%20Serial%22%20doesn't%20have%20a%20tilde%20character%20*%2F%2F%0A.varela%20%7B%20%0A%20%20%20%20font-family%2F:%20'Varela%20Round'%2F%3B%20%0A%20%20%20%20display%2F:%20inline-block%2F%3B%20%0A%20%20%20%20font-size%2F:%20inherit%2F%3B%20%0A%20%20%20%20text-rendering%2F:%20auto%2F%3B%20%0A%20%20%20%20-webkit-font-smoothing%2F:%20antialiased%2F%3B%20%0A%20%20%20%20-moz-osx-font-smoothing%2F:%20grayscale%2F%3B%0A%20%20%20%20transform%2F:%20translate(0,%200)%2F%3B%0A%7D%0A.varela-tilde%2F:after%20%7B%20content%2F:%20%22%5C07e%22%2F%3B%20%7D&pcb:false&plate:false%3B&@_y:0.75&t=%23666666&g:true&p=CHICKLET&a:7&f:2&w:1.0357&h:0.75%3B&=esc&_a:4&fa@:0&:0&:0&:1%3B&w:1.0357&h:0.75%3B&=%0A%0A%0AF1&_w:1.0357&h:0.75%3B&=%0A%0A%0AF2&_w:1.0357&h:0.75%3B&=%0A%0A%0AF3&_w:1.0357&h:0.75%3B&=%0A%0A%0AF4&_w:1.0357&h:0.75%3B&=%0A%0A%0AF5&_w:1.0357&h:0.75%3B&=%0A%0A%0AF6&_w:1.0357&h:0.75%3B&=%0A%0A%0AF7%0A%0A%0A%0A%0A%0A%3Ci%20class%2F='fa%20fa-backward'%3E%3C%2F%2Fi%3E&_fa@:0&:0&:0&:1&:0&:0&:0&:0&:0&:1%3B&w:1.0357&h:0.75%3B&=%0A%0A%0AF8%0A%0A%0A%0A%0A%0A%3Ci%20class%2F='fa%20fa-play'%3E%3C%2F%2Fi%3E%3Ci%20class%2F='fa%20fa-pause'%3E%3C%2F%2Fi%3E&_fa@:0&:0&:0&:1%3B&w:1.0357&h:0.75%3B&=%0A%0A%0AF9%0A%0A%0A%0A%0A%0A%3Ci%20class%2F='fa%20fa-forward'%3E%3C%2F%2Fi%3E&_w:1.0357&h:0.75%3B&=%0A%0A%0AF10%0A%0A%0A%0A%0A%0A%3Ci%20class%2F='fa%20fa-volume-off'%3E%3C%2F%2Fi%3E&_w:1.0357&h:0.75%3B&=%0A%0A%0AF11%0A%0A%0A%0A%0A%0A%3Ci%20class%2F='fa%20fa-volume-down'%3E%3C%2F%2Fi%3E&_w:1.0357&h:0.75%3B&=%0A%0A%0AF12%0A%0A%0A%0A%0A%0A%3Ci%20class%2F='fa%20fa-volume-up'%3E%3C%2F%2Fi%3E&_a:7&w:1.0357&h:0.75%3B&=%3Ci%20class%2F='fa%20fa-eject'%3E%3C%2F%2Fi%3E%3B&@_y:-0.25&g:false&a:5&f:5&fa@:3%3B%3B&=%3Ci%20class%2F=%22varela%20varela-tilde%22%3E%3C%2F%2Fi%3E%0A%60&=!%0A1&=%2F@%0A2&=%23%0A3&=$%0A4&=%25%0A5&=%E2%8C%83%0A6&=%2F&%0A7&=*%0A8&=(%0A9&=)%0A0&_fa@:3&=undefined%3B%3B&=%E2%80%93%0A-&=+%0A%2F=&_g:true&a:4&f:2&w:1.5%3B&=%0A%0A%0Adelete%3B&@_g:false&w:1.5%3B&=%0Atab&_a:7&f:5%3B&=Q&=W&=E&=R&=T&=Y&=U&=I&=O&=P&_a:5%3B&=%7B%0A%5B&=%7D%0A%5D&=%7C%0A%5C%3B&@_a:4&f:2&fa@:1%3B&w:1.75%3B&=esc%0Acontrol&_a:7&f:5%3B&=A&=S&=D&_n:true%3B&=F&=G&_a:5&fa@:0&:1&:0&:0&:0&:0&:1%3B%3B&=%0A%E2%86%90%0A%0A%0A%0A%0AH&_n:true%3B&=%0A%E2%86%93%0A%0A%0A%0A%0AJ&=%0A%E2%86%91%0A%0A%0A%0A%0AK&_sm=alps%3B&=%0A%E2%86%92%0A%0A%0A%0A%0AL&_f:5%3B&=%2F:%0A%2F%3B&_f:5%3B&=%22%0A'&_a:4&f:2&f2:1&w:1.75%3B&=%0A%0Areturn%0Acontrol%3B&@_f:2&w:2.25%3B&=%0Ashift&_a:7&f:5%3B&=Z&=X&=C&=V&=B&=N&=M&_a:5%3B&=%3C%0A,&=%3E%0A.&=%3F%0A%2F%2F&_a:4&f:2&w:2.25%3B&=%0A%0A%0Ashift%3B&@_g:true&h:1.111%3B&=%0Afn&_fa@:0&:0&:5%3B&h:1.111%3B&=%0A%0A%E2%8C%83%0Acontrol&_g:false&h:1.111%3B&=%0A%0A%E2%8C%A5%0Aoption&_w:1.25&h:1.111%3B&=%0A%0A%E2%8C%98%0Acommand&_a:7&w:5&h:1.111%3B&=&_a:4&fa@:5%3B&w:1.25&h:1.111%3B&=%E2%8C%AB%0Adelete&_h:1.111%3B&=%E2%8C%A6%0Ahyper&_x:1&g:true&a:7&f:5&h:0.611%3B&=%E2%86%91%3B&@_y:-0.5&x:11.5&h:0.6111%3B&=%E2%86%90&_h:0.6111%3B&=%E2%86%93&_h:0.6111%3B&=%E2%86%92

## Vim `HJKL` everywhere with [Karabiner](karabiner/.config/karabiner/karabiner.json)

### Navigation

When pressed together with `Command`, `Option` or `CapsLock`, `HJKL` will
become arrow keys (Left/Down/Up/Right):

- `Command` + `H/J/K/L` will perform character-level cursor movements.
  - Hold down an additional `Shift` key to select text.

- `Option` + `H/J/K/L` will perform word-level cursor movements.
  - Hold down an additional `Shift` key to select text.

- `Control` + `H/J/K/L` will perform page-level cursor movements.
  - Hold down an additional `Shift` key to select text.

- `CapsLock` + `N/P` to go down and up.

