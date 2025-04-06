import { App, Astal } from "astal/gtk3";
import { Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import NixOS from "./widgets/nixos.js";
import Time from "./widgets/time.js";

const hyprland = Hyprland.get_default();
const minified = Variable(true);
let override = false;
let currentTimeout = null;

hyprland.connect("event", () => {
    let found = 0;
    for (const client of hyprland.get_clients()) {
        if (client.workspace == hyprland.get_focused_workspace()) {
            found++;
        }
    }

    if(found == 0) {
        if(currentTimeout) {
            clearTimeout(currentTimeout)
        }
        currentTimeout = setTimeout(() => {
            override = true;
            minified.set(false);
        }, 200);
    } else {
        if(currentTimeout) {
            clearTimeout(currentTimeout)
        }
        currentTimeout = setTimeout(() => {
            override = false;
            minified.set(true);
        }, 800);
    }
})

export default function shybar() {
    return <window
            name = "ShyBar"
            className = "ShyBar"
            monitor = {0}
            exclusivity = {Astal.Exclusivity.EXCLUSIVE}
            anchor = {
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.TOP |
                Astal.WindowAnchor.BOTTOM
            }
            application={App}
        >
            <eventbox 
                onHover = { () => { if(!override) minified.set(false) } }
                onHoverLost = { () => { if(!override) minified.set(true) } }
            >
                <box 
                    vertical
                    className = { minified((value) => value ? "BarContainerMini" : "BarContainer") }
                >
                    <NixOS minified = { minified } />
                    <box hexpand vexpand />
                    <Time minified = {minified} />
                </box>
            </eventbox>
        </window>;
}

