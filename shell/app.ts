import { App } from "astal/gtk3";
import style from "./style.css";
import shybar from "./shybar/shybar.js";
import automate from "./automate.js";

App.start({
    css: style,
    main() {
        // shybar(); 
        automate();
    },
    requestHandler(req, res) {
        res("ok");
    },
});

