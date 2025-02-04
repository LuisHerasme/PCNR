const nodos = [
  [18.493137, 69.918273],
  [18.493138, 69.935561],
  [18.484809, 69.910039],
  [18.500816, 69.906818],
  [18.508113, 69.896805],
  [18.484871, 69.893289],
  [18.470304, 69.894795],
  [18.477162, 69.919302],
  [18.453849, 69.921604],
  [18.468656, 69.943828],
  [18.451318, 69.938188],
  [18.478914, 69.950688],
  [18.487378, 69.96012],
  [18.454394, 69.964941],
  [18.481001, 69.976092],
  [18.430122, 69.973917],
  [18.463482, 69.98554],
  [18.498559, 69.977104],
  [18.472034, 69.994046],
  [18.42671, 69.999375]
];

const central = {
  lat: 18.45264,
  lng: -69.98052,
};

function initMap() {
  const elevator = new google.maps.ElevationService();
  console.log("Iniciando.");

  for (let nodo of nodos) {
    console.log(`Procesando nodo.`);
    nodo = { lat: nodo[0], lng: -1 * nodo[1] };
    const camino = [nodo, central];
    elevator.getElevationAlongPath({ path: camino, samples: 256 }, guardar);
  }
}

function guardar(elevations, status) {

  if (status !== "OK") {
    console.log("Error: estado no OK.");
    return;
  }

  let csvContent = "data:text/csv;charset=utf-8,";

  for (let i = 0; i < elevations.length; i++) {
    const pos = elevations[i].location.toJSON();
    csvContent += elevations[i].elevation + "," + pos.lat + "," + pos.lng + "\n";
  }

  const encodedUri = encodeURI(csvContent);
  window.open(encodedUri);
}

window.onload = initMap;
