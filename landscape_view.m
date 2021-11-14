function [vnormals,h1]=landscape_view(vertex,face)
if nargin<2
    error('Not enough arguments.');
end

%white background
set(gcf,'Color','w');
h1=patch('vertices',vertex,'faces',face,'facecolor',[250/255 214/255 165/255],...
         'edgecolor',[0.4 0.4 0.4],'edgealpha',0.3,'linestyle','none'); 

axis equal; 
axis off;

%camproj('perspective');
camproj('orthographic');
camlight headlight 
camlight infinite; 
lighting phong;
set(gcf,'Renderer','OpenGL')
%camera angle
camva(20);
vnormals=get(h1,'VertexNormals');
rzview('off');

