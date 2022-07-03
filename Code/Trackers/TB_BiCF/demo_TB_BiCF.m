
% This demo script runs the BiCF tracker with hand-crafted features on the
% included "person11" video (UAV123@10fps dataset).
%% **Need to change**

tracker_name = 'tb';
% Add paths
setup_paths();

% Load video information
video_path = './sequences/truck2';
[seq, ground_truth] = load_video_info(video_path);

% Run TB_BiCF
results = run_TB_BiCF(seq);
%my work %%%%%%%%%%%%%%%%%%%%%%%%%%
pd_boxes = results.res;
disp(ground_truth);
disp('islammmmmm');
disp(pd_boxes);
result{1} = results;

% plot precision figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_dir = '.\Test_one_seq\';
save_res_dir = [save_dir, tracker_name, '_results\'];
save_pic_dir = [save_res_dir, 'res_picture\'];
if ~exist(save_res_dir, 'dir')
    mkdir(save_res_dir);
    mkdir(save_pic_dir);
end
save([save_res_dir, 'islam', '_', tracker_name], 'results');

% plot precision figure
show_visualization = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%thhhhh--

%precision_plot_save(results.res,ground_truth, 'islam', save_pic_dir, show_visualization);

%success_plot(results.res, ground_truth );


fprintf('FPS: %f',results.fps);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
