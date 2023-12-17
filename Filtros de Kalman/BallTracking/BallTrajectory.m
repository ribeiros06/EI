function [xpos,ypos,radius ]=BallTrajectory

% This function measures the ball radius and its center trajectory of the film recorded in the
% images '1.jpeg' to '60.jpeg' in the child folder 'DATA'. 
%
% No inputs
%
%
% Outputs: 
% 
% xpos - x coordinates of the ball trajectory. A zero value corresponds to the left
% side of the image. x ranges in the interval [0,320]
%
% ypos - y coordinates of the ball trajectory. A zero values corresponds to
% the upper side of the image . y ranges in the interval [0 240]
%
% There are 60 images. However the ball only appears in images 7 to 60. So
% the xpos and ypos are arrays of dimension 54 where the first position corresponds to the
% first image where the ball appears.
%

clear,clf
figure(1)
% compute the background image
Imzero = zeros(240,320,3);
for i = 1:5
Im{i} = double(imread(['DATA/',int2str(i),'.jpg']));
Imzero = Im{i}+Imzero;
end
Imback = Imzero/5;
[MR,MC,Dim] = size(Imback);
radius_m=[];
% loop over all images
for i = 1 : 60
  % load image
  Im = (imread(['DATA/',int2str(i), '.jpg'])); 
  imshow(Im)
  Imwork = double(Im);

  %extract ball
  [cc(i),cr(i),radius,flag] = extractball(Imwork,Imback,i);%,fig1,fig2,fig3,fig15,i);
  if i > 9
      radius_m=[radius_m radius];
  end
  if flag==0
    continue
  end
    hold on
 %   for c = -0.9*radius: radius/20 : 0.9*radius
 %     r = sqrt(radius^2-c^2);
  %    plot(cc(i)+c,cr(i)+r,'g.')
  %    plot(cc(i)+c,cr(i)-r,'g.')
   % end
 %Slow motion!
      pause(0.02)
end

radius=mean(radius_m);
xpos=cc(7:60);
ypos=cr(7:60);
