function [vnormals,h1]=plane_view(vertex,face,options)
if nargin<2
    error('Not enough arguments.');
end

%set background to white
% set(gcf,'Color',[216/255,236/255,249/255]);
set(gcf,'Color',[0,0,0]);

h1=patch('vertices',vertex,'faces',face,'facecolor',[250/255 214/255 165/255],...
         'edgecolor',[0.4 0.4 0.4],'edgealpha',0.3,'linestyle','none'); 

%
axis equal; 
axis off;
%
camproj('perspective');
% camproj('orthographic');
camlight headlight 

set(gcf,'Renderer','OpenGL')
%% Lighting gouraud for smoother lighting
% lighting gouraud;
lighting phong;

%% Set Viewing Angle
camva(45);
vnormals=get(h1,'VertexNormals');
rzview('off');

