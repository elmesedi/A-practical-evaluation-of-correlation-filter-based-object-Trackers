% This demo script runs the DRCF tracker on the included video.

% Add paths
setup_paths();

%  Load video information
base_path  =  './sequences';
%video  = choose_video(base_path);
video = 'wakeboard5';

video_path = [base_path '/' video];
[seq, gt_boxes] = load_video_info(video_path);

% Run DRCF 
results = run_DRCF(seq);
%my work
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 pd_boxes = results.res;
 disp(gt_boxes);
 disp('dddddddddd');
 disp(pd_boxes);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COMMENT FOR THIS PART %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
 thresholdSetOverlap = 0: 0.05 : 1;
 success_num_overlap = zeros(1, numel(thresholdSetOverlap));
 res = calcRectInt(gt_boxes, pd_boxes);
 for t = 1: length(thresholdSetOverlap)
     success_num_overlap(1, t) = sum(res > thresholdSetOverlap(t));
 end
 cur_AUC = mean(success_num_overlap) / size(gt_boxes, 1);
 disp('valiiiii');
 disp(cur_AUC)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
FPS_vid = results.fps;
display([video  '---->' '   FPS:   ' num2str(FPS_vid) ]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
show_visualization=1;
disp('GROUND TRU');
disp(gt_boxes);
disp('FPS');
disp(results.fps);
disp('NEW LOCATION');
disp(pd_boxes);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
precision_plot_save(pd_boxes, gt_boxes, 'my title', 'savedir', show_visualization);
success_plot( pd_boxes, gt_boxes);
%fprintf('disp:fps: %f',results.fps);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%