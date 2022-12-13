vertex_matrix = [[0 0 0]; [0 1 0]; [0 1 1]; [0 0 1]; [1 0 0]; [1 1 0]; [1 1 1]; [1 0 1]];

faces_matrix = [[1 2 3 4]; [4 3 7 8];[7 8 5 6]; [1 5 6 2]; [3 7 6 2]; [1 4 8 5]];

color_matrix = vertex_matrix * 255;

patch('Vertices',vertex_matrix,'Faces',faces_matrix,...
    'FaceVertexCData',color_matrix,'FaceColor','interp');

view(3); axis square