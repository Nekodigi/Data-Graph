//icondata https://github.com/djaiss/mapsicon
//covid data https://github.com/owid/covid-19-data/tree/master/public/data
//country code data https://datahub.io/core/country-list

StringDict iconDir = new StringDict();

void setup(){
  //fullScreen();
  size(1000, 200);
  background(255);
  fill(255);
  Table countryCode = loadTable("country-code.csv", "header");
  for(TableRow row : countryCode.rows()){
    String name = row.getString("Name");
    String code = row.getString("Code").toLowerCase();
    name = split(name, ',')[0];
    row.setString("Name", name);
    println(name, code);
    iconDir.set(name, "icon/"+code+"/256.png");
  }
  Table covidData = loadTable("owid-covid-data.csv", "header");
  covidData.setColumnType("total_cases", Table.FLOAT);
  covidData.sortReverse("total_cases");
  float off = 0;
  for(TableRow row : covidData.rows()){
    String date = row.getString("date");
    if(date.contains("2020-05-05")){
      String location = row.getString("location");
      if(!location.contains("World")){
        String total_cases = row.getString("total_cases");
        float ts = pow(float(total_cases), 0.5)/6;
        String path = iconDir.get(location);
        if(path != null){
          PImage img = loadImage(path);
          if(ts >= 1 && img != null){
            image(img, off, height/2-ts/2, ts, ts);
            TableRow tr = countryCode.findRow(location, "Name");
            String code = "";
            if(tr != null)code = tr.getString("Code");
            textSize(ts/5);
            textAlign(CENTER);
            text(code, off+ts/2, height/2);
            off += ts;
          }
        }
      }
    }
  }
}

void draw(){
  
}
