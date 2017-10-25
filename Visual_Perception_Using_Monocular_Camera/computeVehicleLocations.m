%%
% *computeVehicleLocations* calculates the location of a vehicle
% in vehicle coordinates, given a bounding box returned by a detection
% algorithm in image coordinates. It returns the center location of the
% bottom of the bounding box in vehicle coordinates. Because a monocular
% camera sensor and a simple homography are used, only distances along the
% surface of the road can be computed. Computation of an arbitrary location
% in 3-D space requires use of a stereo camera or another sensor capable of
% triangulation.
function locations = computeVehicleLocations(bboxes, sensor)

locations = zeros(size(bboxes,1),2);
for i = 1:size(bboxes, 1)
    bbox  = bboxes(i, :);

    % Get [x,y] location of the center of the lower portion of the
    % detection bounding box in meters. bbox is [x, y, width, height] in
    % image coordinates, where [x,y] represents upper-left corner.
    yBottom = bbox(2) + bbox(4) - 1;
    xCenter = bbox(1) + (bbox(3)-1)/2; % approximate center

    locations(i,:) = imageToVehicle(sensor, [xCenter, yBottom]);
end
end
