# NixOS + Hyprland Dotfiles

My daily driver setup on an HP Victus 15 (AMD iGPU + RTX 4060). It works, I can play games on it without crying, and the rice is semi-decent. 

I'm dropping this here mostly to get it out of my local machine, but if you're reading this and you actually know what you're doing with Nix flakes and Wayland compositors, 
<h1>I could use some heavy feedback. </h1>

## Current Setup Stack

* **OS:** NixOS (Flake-based)
* **WM:** Hyprland + Waybar + Rofi
* **Terminal/Editor:** Kitty + Neovim (Gruvbox)
* **Graphics:** Hybrid AMD/NVIDIA (PRIME setup with `gamemode` and Proton-GE)

---

## Where I'm Likely Doing Things Suboptimally

If you look through the code and find yourself thinking "why the hell did they do it that way," you're probably right. Specifically, I'm looking for input on:

### 1. Hybrid Graphics & Power Profiles
Running `amdgpu` and `nvidia` together on a laptop is always a mild nightmare. Right now it's brute-forced with basic PRIME sync and gamemode. If there's a cleaner way to handle power states and offloading without waking up the dGPU and frying the battery in 40 minutes, I'm all ears.

### 2. Flakes & Home-Manager Architecture
Some dotfiles (`.config` dirs) are still sitting as raw files or getting dragged along, rather than being cleanly abstracted into pure Nix modules. If you have a solid, scalable structure for managing window manager configs without losing the flexibility of tweaking them directly, let me know how you structured yours.

### 3. Wayland Ecosystem Quirks
Still ironing out minor annoyances with window rules, rendering behaviors under hybrid graphics, and notification daemons. If you've solved edge cases with XWayland scaling or Vulkan topology initialization quirks on similar hardware, drop an issue or a PR.

---

## Pull Requests & Critique

Don't hold back. If my modules look bloated, if my Nix expressions are dirty, or if there's a better tool I should be using instead of whatever hack I put together, open an issue or send a PR. 

Clone it, tear it apart, or suggest a better way to wire it.
