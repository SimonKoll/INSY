db.artikel.insert({
    ArtikelNr: 1001,
    Verkaufsstart: new Date(2015,1,1),
    Tags: ["Monitor", 22, "Acer"],
    Spezifikation: {
       Spannung: 240,
       Leistung: 25
    }
}) 

db.artikel.insert({
    ArtikelNr: 1002,
    Verkaufsstart: new Date(2017,9,21),
    Tags: ["Monitor", 24, "Acer", "3D"],
    Spezifikation: {
       Spannung: 240,
       Leistung: 35
    }
}) 

db.artikel.insert({
    ArtikelNr: 1003,
    Verkaufsstart: new Date(2017,1,1),
    Tags: ["Laptop", "i7", "SSD"],
    Spezifikation: {
       Spannung: 240,
       Leistung: 55
    }
}) 
