package altronix.ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class UpdateState extends flixel.FlxState
{
  public static var downloadPercent:Float = 0.0;
  public static var downloadStatus:DownloadingStatus = NOT_STARTED;

  var downloadBar:FlxBar;
  var downloadText:FlxText;

  override function create():Void
  {
    var bg:FlxSprite = new FlxSprite(Paths.getBGPath());
    bg.scrollFactor.x = 0;
    bg.scrollFactor.y = 0.17;
    bg.color = FlxColor.GREEN;
    bg.setGraphicSize(Std.int(bg.width * 1.2));
    bg.updateHitbox();
    bg.screenCenter();
    add(bg);

    downloadText = new FlxText(0, 0, 0, "Downloading...", 16);
    downloadText.screenCenter(XY);
    downloadText.visible = false;
    add(downloadText);

    downloadBar = new FlxBar(0, FlxG.height - 40, LEFT_TO_RIGHT, FlxG.width, 40, "downloadPercent", 0, 1);
    downloadBar.createFilledBar(FlxColor.BLACK, FlxColor.LIME);
    downloadBar.visible = false;
    add(downloadBar);
  }

  override function update(elapsed:Float):Void
  {
    super.update(elapsed);

    if (downloadStatus == NOT_STARTED)
    {
      downloadText.visible = true;
      downloadBar.visible = true;
      downloadStatus = DOWNLOADING;
      sys.thread.Thread.create(() -> altronix.updater.Downloader.downloadLatestZip());
    }

    if (downloadStatus == DOWNLOADING)
    {
      downloadBar.value = downloadPercent;
    }

    if (downloadStatus == DOWNLOADED)
    {
      downloadBar.visible = false;
      downloadText.text = "Updating...";
      downloadText.screenCenter(XY);
      downloadStatus = UPDATING;
      sys.thread.Thread.create(() -> altronix.updater.Updater.updateGame());
    }
  }
}

enum DownloadingStatus
{
  NOT_STARTED;
  DOWNLOADING;
  DOWNLOADED;
  UPDATING;
}
