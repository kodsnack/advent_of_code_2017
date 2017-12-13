function buildGraph(input) {
    let graph = new Map();
    let edges = input.split('\n');
    edges.forEach(edge => {
        let vertices = edge.split(' <-> ');
        let vCurrent = vertices[0];
        let vOthers = vertices[1].split(', ');
        vOthers.forEach(vOther => {
            add(vCurrent, vOther);
            add(vOther, vCurrent);
        });
    });
    function add(v1, v2) {
        if(graph.has(v1)) {
            graph.get(v1).push(v2);
        } else {
            graph.set(v1, [v2]);
        }
    }
    return graph;
}

function nrOfVerticesInCcFor(vertex, input) {
    let visited = new Set();
    let graph = buildGraph(input);
    dfs(vertex);

    function dfs(v) {
        visited.add(v);
        graph.get(v).forEach(adj => {
            if(!visited.has(adj)) {
                dfs(adj);
            }
        });
    }
    return visited.size;
}

function nrOfConnectedComponents(input) {
    let visited = new Set();
    let graph = buildGraph(input);
    let ccs = 0;
    for(let vertex of graph.keys()) {
        if(!visited.has(vertex)) {
            dfs(vertex);
            ccs++;
        }
    }

    function dfs(v) {
        visited.add(v);
        graph.get(v).forEach(adj => {
            if(!visited.has(adj)) {
                dfs(adj);
            }
        });
    }

    return ccs;
}

module.exports.buildGraph = buildGraph;
module.exports.nrOfVerticesInCcFor = nrOfVerticesInCcFor;
module.exports.nrOfConnectedComponents = nrOfConnectedComponents;
