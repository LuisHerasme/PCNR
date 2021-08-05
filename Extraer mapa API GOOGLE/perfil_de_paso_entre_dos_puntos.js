// Para ejecutar este codigo pergarlo en el siguiente editor en linea:
// https://jsfiddle.net/L01jmore/15/

const muestras = 100;

const inicio = {
  lat: 18.45264,
  lng: -69.98052,
};

const fin = {
  lat: 18.5833333,
  lng: -70.2833333,
};

function initMap() {
  const elevator = new google.maps.ElevationService();
  console.log("Iniciando.");
  
  const camino = [inicio, fin];
  elevator.getElevationAlongPath({ path: camino, samples: muestras }, guardar);
}

function guardar(elevations, status) {

  if (status !== "OK") {
    console.log("Error: estado no OK.");
    return;
  }

  let csvContent = "data:text/csv;charset=utf-8,";

  for (let i = 0; i < elevations.length; i++) {
    const punto = elevations[i].location.toJSON();
    csvContent += elevations[i].elevation + "," + punto.lat + "," + punto.lng + "\n";
  }

  const encodedUri = encodeURI(csvContent);
  download("data.csv", encodedUri);
}

function download(filename, text) {
  var element = document.createElement('a');
  element.setAttribute('href', text);
  element.setAttribute('download', filename);

  element.style.display = 'none';
  document.body.appendChild(element);
  element.click();
  document.body.removeChild(element);
}
