
% This demo script runs the BiCF tracker with hand-crafted features on the
% included "person11" video (UAV123@10fps dataset).

% Add paths
setup_paths();

% Load video information
video_path = './sequences/person11';
[seq, ground_truth] = load_video_info(video_path);
disp(ground_truth);
% Run ECO
results = run_BiCF(seq);
result{1} = results; 
show_visualization=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(results.res);
disp('ytyyyyyyyyyy')
disp(ground_truth);
precision_plot_save(results.res, ground_truth, 'dataset', 'ddd', show_visualization);
success_plot( results.res, ground_truth);
fprintf('fps: %f',results.fps);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%