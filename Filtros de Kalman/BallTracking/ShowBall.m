function ShowBall(xest,yest,radius)

% This function shows the estimated ball position of the film recorded in the
% images '1.jpeg' to '60.jpeg' in the child folder 'DATA'. 
%
% Inputs:
% xest - estimated coordinates of the x position
% yest - estimated coordinates of the y position
%
% No outputs. 
% 
% xest - estimated x coordinates of the ball trajectory. A zero value corresponds to the left
% side of the image. x ranges in the interval [0,320]
%
% yest - y coordinates of the ball trajectory. A zero values corresponds to
% the upper side of the image . y ranges in the interval [0 240]
%
% radius - Radius of the ball computed in the BallTrajectory function
%
% 
% There are 60 images. However the ball only appears in images 7 to 60. So
% the xpest and yest are arrays of dimension 54 where the first position corresponds to the
% first image where the ball appears.


clc
clf
figure(1)
% compute the background image
Imzero = zeros(240,320,3);
for i = 1:5
Im{i} = double(imread(['DATA/',int2str(i),'.jpg']));
Imzero = Im{i}+Imzero;
end
Imback = Imzero/5;
[MR,MC,Dim] = size(Imback);
% loop over all images
for i = 1 : 60
  % load image
  Im = (imread(['DATA/',int2str(i), '.jpg'])); 
  imshow(Im)
  Imwork = double(Im);

  %extract ball
  [cc,cr,radius_d,flag] = extractball(Imwork,Imback,i);%,fig1,fig2,fig3,fig15,i);
  if flag==0
    continue
  end
    hold on
    for c = -0.9*radius: radius/20 : 0.9*radius
      r = sqrt(radius^2-c^2);
      plot(xest(i-6)+c,yest(i-6)+r,'g.')
      plot(xest(i-6)+c,yest(i-6)-r,'g.')
    end
 %Slow motion!
      pause(0.02)
end

