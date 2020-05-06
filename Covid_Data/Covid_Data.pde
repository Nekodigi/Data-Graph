//icondata https://github.com/djaiss/mapsicon
//covid data https://github.com/owid/covid-19-data/tree/master/public/data
//country code data https://datahub.io/core/country-list

void setup(){
  fullScreen();
  background(255);
  fill(0);
  Table table = loadTable("owid-covid-data.csv", "header");
  table.setColumnType("total_cases", Table.FLOAT);
  table.sortReverse("total_cases");
  float off = 0;
  for(TableRow row : table.rows()){
    String date = row.getString("date");
    if(date.contains("2020-05-05")){
      String location = row.getString("location");
      if(!location.contains("World")){
        String total_cases = row.getString("total_cases");
        float ts = pow(float(total_cases), 0.5)/6;
        if(ts >= 1){println(ts);
          textSize(ts);
          off += ts;
          text(location, 0, off);
        }
      }
    }
  }
}

void draw(){
  
}
