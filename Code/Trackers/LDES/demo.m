
close all;
%~/Data/tob100
%~/Data/tb100/
datasets={ struct('name','OTB-100','basePath','videos/')};
    
%default settings for demo
show_visualization = 1; 
show_plots = 1;

%ask the user for the video, then call self with that video name.
[video, base_path, dataset] = choose_video(datasets);

% video = 'Toy';
% base_path = 'videos/';
% dataset = 'OTB-100';

%get image file names, initial state, and ground truth for evaluation
[img_files, pos, target_sz, rot,ground_truth, video_path,datasetParam] = load_video_info(base_path, video,dataset);

%call tracker function with all the relevant parameters
[~,rects,~,~,~, time] = tracker(video_path, img_files, pos, target_sz, rot, show_visualization);

%calculate and show precision plot, as well as frames-per-second
%precisions = precision_plot(rects(:,[1,2]), ground_truth, video, show_plots);
fps = numel(img_files) / time;

%fprintf('%12s - Precision (20px):% 1.3f, FPS:% 4.2f\n', video, precisions(20), fps)

%return precisions at a 20 pixels threshold
%precision = precisions(20);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
show_visualization=1;
disp('#######GROUND TRU#############');
disp(ground_truth);
disp('#########FPS##################');
disp(fps);
disp('#########NEW LOCATION#########');
disp(rects);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
precision_plot_save(rects, ground_truth, 'my title', 'savedir', show_visualization);
success_plot( rects, ground_truth);
%fprintf('disp:fps: %f',fps);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


