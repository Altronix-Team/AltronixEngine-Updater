package;

class Paths {
    public static inline function getProgramPath():String {
        var curCwd = Sys.getCwd();

        return curCwd.split('updater/')[0];
    }

    public static inline function getBGPath():String {
        return "assets/images/menuDesat.png";
    }
}

