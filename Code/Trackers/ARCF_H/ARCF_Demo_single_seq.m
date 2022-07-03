
%   This script runs the implementation of ARCF for visual tracking.
%   Some functions are borrowed from other papers (SRDCF, UAV123 Benchmark)
%   and their copyright belongs to the paper's authors.

clear; clc; close all;
[user,sys] = memory;%place in the begging of your program

addpath(genpath('.'));

pathAnno = '.\seq\';
seqs = configSeqs_demo_for_ARCF;
%% 

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
    
    rect_anno = dlmread([pathAnno s.name '.txt']);
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
    
    %   Run ARCF-H main function
    res = run_ARCF_H(subS, 0, 0);
    %   To run ARCF-HC, comment the line above and uncomment the line below
%     res = run_ARCF(subS, 0, 0);

    res.len = subS.len;
    res.annoBegin = subS.annoBegin;
    res.startFrame = subS.startFrame;

    results{idx} = res;
    
    %   Load video information
    ground_truth = subAnno{1};

    gt_boxes = [ground_truth(:,1:2), ground_truth(:,1:2) + ground_truth(:,3:4) - ones(size(ground_truth,1), 2)];


    %   compute the OP
  %  pd_boxes = results.res;
    
   % pd_boxes = [pd_boxes(:,1:2), pd_boxes(:,1:2) + pd_boxes(:,3:4) - ones(size(pd_boxes,1), 2)  ];
    %OP = zeros(size(gt_boxes,1),1);
    %for i=1:size(gt_boxes,1)
     %   b_gt = gt_boxes(i,:);
      %  b_pd = pd_boxes(i,:);
       % OP(i) = computePascalScore(b_gt,b_pd);
        %disp(b_pd);
    %end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
show_visualization=1;
disp('GROUND TRU');
disp(ground_truth);
disp('FPS');
disp(res.fps);
disp('NEW LOCATION');
disp(res.res);
fid =fopen('D:\trytex\res.txt', 'w' );
fprintf(fid, '%g\t%g\n', res.res);
fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%precision_plot_save(res.res, ground_truth, 'my title', 'savedir', show_visualization);
success_plot( res.res, ground_truth);
fprintf('disp:fps: %f',res.fps);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [user2,sys2] = memory;%place in the end of your program
memory_used_in_bytes=user2.MemAvailableAllArrays-user.MemAvailableAllArrays;
disp(memory_used_in_bytes);
    %OP_vid = sum(OP >= 0.5) / numel(OP);
    %FPS_vid = results.fps;
    %display([video  '---->' '   FPS:   ' num2str(FPS_vid)   '    op:   '   num2str(OP_vid)]);
end