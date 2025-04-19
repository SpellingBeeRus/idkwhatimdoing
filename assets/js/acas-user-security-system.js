// DETECT EXCESSIVE TAB SWITCHING
(() => {
    const tabSwitchThreshold = 2;
    const tabSwitchTimeout = 10000;

    let tabSwitchCount = 0;
    let lastSwitchTime = Date.now();

    if(typeof document.hidden !== "undefined") {
        function handleVisibilityChange() {
            if(document.hidden) {
                const currentTime = Date.now();

                const timeElapsed = currentTime - lastSwitchTime;

                if (timeElapsed >= tabSwitchTimeout) {
                    tabSwitchCount = 0;
                }

                tabSwitchCount++;

                if (tabSwitchCount >= tabSwitchThreshold) {
                    tabSwitchCount = 0;

                    const msg = transObj?.excessiveTabChangeWarning;
                    toast.warning(msg, 25000);
                }

                lastSwitchTime = currentTime;
            }
        }

        document.addEventListener("visibilitychange", handleVisibilityChange, false);
    }
})();

// DETECT CONSISTANT AND TOO FAST MOVE TIMES
(() => {

});