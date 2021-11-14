clear, close all;


%% Begin Global Vars

% Controls the scaling of the terrain mesh in the z axis
zscaling=0.9;

% number of sample points along the curve
t_sampling = 1000;

% Controls something in catmull rom
tension = -0.1;

% Speed is defined as the delay between successive frames (ie
% tsampling points) delay=1/speed
speed = 100;

% Vars to control ribbon width/normal offset
ribbon_width = 0.0025;
ribbon_offset = -0.005;

% All waypoints Customize it later
sphere_size = 0.003;
% waypoints = rand(10,3);
% waypoints = [rand(1)*0.5 rand(1)*0.5 rand(1)*0.3;
%     rand(1)*0.5 rand(1)*0.5 rand(1)*0.3
%     0.5+rand(1)*0.5 rand(1)*0.5 rand(1)*0.3
%     0.5+rand(1)*0.5 rand(1)*0.5 rand(1)*0.3
%     rand(1)*0.5 0.5+rand(1)*0.5 rand(1)*0.3
%     rand(1)*0.5 0.5+rand(1)*0.5 rand(1)*0.3
%     0.5+rand(1)*0.5 0.5+rand(1)*0.5 rand(1)*0.3
%     0.5+rand(1)*0.5 0.5+rand(1)*0.5 rand(1)*0.3
%     rand(1) rand(1) rand(1)*0.3
%     rand(1) rand(1) rand(1)*0.3];

% waypoints = [0.2554    0.9088    0.2384
%     0.2234    0.6532    0.1526
%     0.0918    0.1842    0.0977
%     0.3723    0.0945    0.2060
%     0.5870    0.2077    0.0904
%     0.8901    0.0406    0.2388
%     0.8879    0.2434    0.1308
%     0.8759    0.5002    0.0867
%     0.8222    0.6893    0.1435
%     0.9164    0.8754    0.0817
%     0.9    0.8    0.08];

waypoints = [0.213521 0.990796 0.294296
    0.275016 0.861078 0.505282
    0.301295 0.767053 0.551794
    0.354360 0.696472 0.510619
    0.581936 0.648709 0.595387
    0.654241 0.609710 0.608926
    0.733507 0.491952 0.517398
    0.816315 0.370854 0.380087
    0.862499 0.072140 0.632931
    0.970278 0.177406 0.402038];

%% End Global Variables

[p,t] = loadmesh('terrain.off', zscaling);
p = p';

n_waypoints = size(waypoints, 1);
%waypoints = [waypoints ones(n_waypoints,1) * 0.5];
ordered_pts = shortestpath_through_all_pts(waypoints);
%ordered_pts = flipud(ordered_pts);

seg_n = chord_length_parametrization(ordered_pts) * t_sampling;
curve = get_curve_data_catmullrom(ordered_pts, seg_n, tension)';
reparam_seg_n = reparam_curve(curve,ordered_pts) .* t_sampling; 
curve = get_curve_data_catmullrom(ordered_pts, reparam_seg_n, tension)';



% CS = cat(1,0,cumsum(sqrt(sum(diff(ordered_pts,[],1).^2,2))));
% dd = interp1(CS, ordered_pts, unique([CS(:)' linspace(0,CS(end),1000)]),'makima');
% 
% figure, hold on
% plot3(ordered_pts(:,1),ordered_pts(:,2),ordered_pts(:,3),'.b-')
% plot3(curve(:,1),curve(:,2),curve(:,3),'.r-')
% plot3(dd(:,1),dd(:,2),dd(:,3),'.g-')
% axis image, view(3), legend({'Original','Catmoll rom Spline','Interpolation'})

figure;
%pv = subplot(1,2,2);
pv = subplot(1,1,1);
% plane_view(p,t');
observer_view(p,t');
pv.Clipping = "off";
pv.CameraViewAngle = 30;

hold on;

plot_path_ribbon(pv, curve, ribbon_width, ribbon_offset);

figure;
%mmv = subplot(1,2,1);
mmv = subplot(1,1,1);
% minimap(p,t');
landscape_view(p,t');
hold on;
plot3(curve(:,1), curve(:,2), curve(:,3), 'r.');

for i = [1:n_waypoints]
    
    plot3(mmv,waypoints(i,1),waypoints(i,2),waypoints(i,3),'g.', ...
                         'MarkerSize', 12);
    [x,y,z] = sphere();
    r = sphere_size;
    surf(pv,x*r+waypoints(i,1), y*r+waypoints(i,2), z*r+waypoints(i,3));
    %    plot3(pv,waypoints(i,1),waypoints(i,2),waypoints(i,3),'g.', ...
    %                    'MarkerSize', 40);

end

minimap_cam_height = 1;
fly_along_curve(curve, pv, mmv, speed, minimap_cam_height);
rzview('on')
