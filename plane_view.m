function [vnormals,h1]=plane_view(vertex,face,options)

%
%   'options' is a structure that may contains:
%       - 'edge_color' :  float specifying the color of the edges.
%       - 'face_color' :  float specifying the color of the faces.
%       - 'face_vertex_color' : color per vertex or face.


if nargin<2
    error('Not enough arguments.');
end
if nargin<3
    options.null = 0;
end



if ~isfield(options, 'face_color')
    options.face_color = 0.6;
end
face_color = options.face_color;

if ~isfield(options, 'edge_color')
    options.edge_color = 0.4;
end
edge_color = options.edge_color;

if ~isfield(options, 'face_vertex_color')
    options.face_vertex_color = [];
end
face_vertex_color = options.face_vertex_color;

%set background to white
set(gcf,'Color',[216/255,236/255,249/255]);
%set(gcf,'Color',[0,0,0]);


if isempty(face_vertex_color)
    sprintf("Empty Color")
    h1=patch('vertices',vertex,'faces',face,'facecolor',[250/255 214/255 165/255],...
             'edgecolor',[0.4 0.4 0.4],'edgealpha',0.3,'linestyle','none'); 
else
    nverts = size(vertex,1);
    % vertex_color = rand(nverts,1);
    if size(face_vertex_color,1)==size(vertex,1)
        shading_type = 'interp';
    else
        shading_type = 'flat';
    end
    h1=patch('vertices',vertex,'faces',face,'FaceVertexCData',face_vertex_color,...
             'FaceColor',shading_type,'linestyle','none');
end
%
axis equal; 
axis off;
%
camproj('perspective');
% camproj('orthographic');
camlight headlight 
%
%light('Position',[1 1 5],'Style','infinite','color','y');
%light('Position',[0.43 0.5 0.75],'Style','infinite','color','w');
%set(h1,'edgelighting','phong');
%camlight infinite; lighting phong;
%
set(gcf,'Renderer','OpenGL')


lims=real(boundbox(vertex,face));
lipos=[lims(1)+lims(2) lims(3)+lims(4) lims(5)+lims(6)]/2;

%set(h1,'edgelighting','phong');
%hc=camlight('local');
%set(hc,'color','b');

% %light('Position',[2 1 15],'Style','infinite','color','y');
% light('Position',[lims(2) lims(4) 0],'Style','local','color',[ 0.000 0.000 0.627 ]);
% %light('Position',[0 lims(4) lims(6)],'Style','local','color',[ 0.855 0.804 0.996 ]);
% light('Position',[0 lims(4) lims(6)],'Style','local','color',[ 0.000 0.502 1.000 ]);
% light('Position',[lims(2) 0 lims(6)],'Style','local','color',[ 0.855 0.804 0.996 ]);
% light('Position',[0 lims(3) lims(5)-lims(6)-2],'Style','local','color',[ 0.906 0.306 0.012 ]); 
% %camproj('perspective');( picking works only with ortho
% %light('Position',[2 1 15],'Style','infinite','color','y');

%% Lighting gouraud for smoother lighting
% lighting gouraud;
lighting phong;

%% Set Viewing Angle
camva(45);


%campos([-6,-6,-1]);
% %%%added
%view(3);
%cam_pos=get(gca,'CameraPosition')
%tar_pos=get(gca,'CameraTarget')
%cam_pos=0.3.*(cam_pos-tar_pos)+tar_pos;
%set(gca,'CameraPosition',cam_pos);
% %%%%end added

vnormals=get(h1,'VertexNormals');
rzview('off');

