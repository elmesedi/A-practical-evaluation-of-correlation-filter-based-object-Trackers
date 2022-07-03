
%   This script runs the implementation of IBRI for visual tracking.
%   Some functions are borrowed from other papers (SRDCF, UAV123 Benchmark)
%   and their copyright belongs to the paper's authors.

clear; clc; close all;
addpath(genpath('.'));

tracker_name = 'islam';

pathAnno = '.\seq\';
seqs = configSeqs_demo_for_IBRI;

idx = 1;

for idxSeq=1:length(seqs)
    s = seqs{idxSeq};
    
    video_path = s.path;
        
    s.len = s.endFrame - s.startFrame + 1;
    s.s_frames = cell(s.len,1);
    nz	= strcat('%0',num2str(s.nz-2),'d'); %number of zeros in the name of image
    for i=1:s.len
        image_no = s.startFrame + (i-1);
        id = sprintf(nz,image_no);
        s.s_frames{i} = strcat(s.path,id,'.',s.ext);
    end
    
    img = imread(s.s_frames{1});
    [imgH,imgW,ch]=size(img);
    
    rect_anno = dlmread([pathAnno s.name '_gt.txt']);
    numSeg = 20;
    
    [subSeqs, subAnno]=splitSeqTRE(s,numSeg,rect_anno);

    subS = subSeqs{1};
    subSeqs=[];
    subSeqs{1} = subS;

    subA = subAnno{1};
    subAnno=[];
    subAnno{1} = subA;
    results = [];

    subS = subSeqs{idx};

    subS.name = [subS.name '_' num2str(idx)];
    
    res = run_IBRI(subS, 0, 0);

    res.len = subS.len;
    res.annoBegin = subS.annoBegin;
    res.startFrame = subS.startFrame;

    results{idx} = res;
    
    %   Load video information
    ground_truth = subAnno{1};

    gt_boxes = [ground_truth(:,1:2), ground_truth(:,1:2) + ground_truth(:,3:4) - ones(size(ground_truth,1), 2)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(gt_boxes)
show_visualization=1;
disp('GROUND TRU');
disp(rect_anno);
disp('FPS');
disp(res.fps);
disp('NEW LOCATION');
disp(res.res);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
precision_plot_save(res.res, rect_anno, 'my title', 'savedir', show_visualization);
%success_plot( res.res, rect_anno);
fprintf('disp:fps: %f',res.fps);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end