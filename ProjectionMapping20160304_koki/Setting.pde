class PMSetting {

  String settingFileName="settingdata.dat";
  //PrintWriter outfile;
  PMSetting() {
    load();
  }
  void load() {
    String[] lines;
    try {
      lines = loadStrings(settingFileName);
    }
    catch(NullPointerException e) {
      println(e);
      println("File error and use default paramaters.");
      return;
    }
    if (lines == null ) {
      println("No file and use default paramaters.");
      return;
    }
    println("Load " + settingFileName + "...");
    for (String l : lines) {
      String[] co = split(l, ' ');
      if (co[0].equals("scale")) {
        scale = float(co[1]);
      } else if (co[0].equals("threshold")) {
        threshold = int(co[1]);
      } else if (co[0].equals("contrast")) {
        contrast = float(co[1]);
      } else if (co[0].equals("blurSize")) {
        blurSize = int(co[1]);
      } else if (co[0].equals("transdistance")) {
        transdistance = float(co[1]);
      }
    }
    println("Done");
    println(lines);
  }
  void save() {
    String[] str = {
      "scale " + scale, 
      "threshold " + threshold, 
      "contrast " + contrast, 
      "blurSize " + blurSize, 
      "transdistance " + transdistance
    };
    saveStrings(settingFileName, str);
    println("Setting file was updated:  "+settingFileName);
    println(str);
  }
}

class ControllPanel {
  ControlP5 cp5;
  Accordion accordion;

  ControllPanel(ControlP5 c) {
    cp5 = c;
    this.init();
  }

  void update() {
    this.show();
    scale = cp5.getController("Zoom").getValue();
    threshold = int(cp5.getController("Threshold").getValue());
    contrast = cp5.getController("Contrast").getValue();
    transdistance = int(cp5.getController("Transdistance").getValue());
    blurSize = int(cp5.getController("BlurSize").getValue());
  }
  void show() {
    cp5.show();
  }

  void hide() {
    cp5.hide();
  }

  void init() {
    println("init ControllPanel ...");
    //contains a button and a slider
    Group sl = cp5.addGroup("SETTING")
      .setBackgroundColor(color(0, 64))
        .setBackgroundHeight(220)
          ;

    cp5.addSlider("Zoom")
      .setPosition(20, 20)
        .setSize(100, 20)
          .setValue(scale)
            .setRange(1, 8)
              .moveTo(sl)
                ;

    cp5.addSlider("Threshold")
      .setPosition(20, 50)
        .setSize(100, 20)
          .setValue(threshold)
            .setRange(130, 254)
              .moveTo(sl)
                ;

    cp5.addSlider("Contrast")
      .setPosition(20, 80)
        .setSize(100, 20)
          .setValue(contrast)
            .setRange(1, 10)
              .moveTo(sl)
                ;

    cp5.addSlider("BlurSize")
      .setPosition(20, 110)
        .setSize(100, 20)
          .setValue(blurSize)
            .setRange(1, 10)
              .moveTo(sl)
                ;

    cp5.addSlider("Transdistance")
      .setPosition(20, 140)
        .setSize(100, 20)
          .setValue(transdistance)
            .setRange(-500, 500)
              .moveTo(sl)
                ;

    cp5.addButton("save")  //push -> saveメソッド実行
      .setPosition(50, 180)
        .setSize(90, 23)
          .moveTo(sl)
            ;

    // create a new accordion
    // add sl to the accordion.
    accordion = cp5.addAccordion("acc")
      .setPosition(40, 40)
        .setWidth(200)
          .addItem(sl)
            ;

    accordion.open(0);

    accordion.setCollapseMode(Accordion.SINGLE);

    cp5.mapKeyFor(new ControlKey() {
      public void keyEvent() {
        controllpanel.update();
        pmsetting.save();
        controllpanel.hide();
      }
    }
    , ALT, 's');
  }
}
