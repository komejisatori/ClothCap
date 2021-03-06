function [] = garment_fitting( ...
    mesh_scan, label_scan, garments_scan, ...
    mesh_smpl, label_smpl, garments_smpl)

global is_first;
global mesh_prefix;
global result_dir;
    
% for skin    
% [vertices_skin, pose_skin] = align_skin(garments_scan.skin, garments_smpl.skin, ...
%     mesh_scan, mesh_smpl, label_smpl);
% save([result_dir, filesep, mesh_prefix, '_pose_skin.mat'], 'pose_skin');

% for shirt    
[vertices_shirt, ~] = align_garment(garments_scan.shirt, garments_smpl.shirt, ...
    mesh_scan, mesh_smpl, label_smpl, 'shirt', 10);
% save([result_dir, filesep, mesh_prefix, '_pose_shirt.mat'], 'pose_shirt');

% for pants    
[vertices_pants, ~] = align_garment(garments_scan.pants, garments_smpl.pants, ...
    mesh_scan, mesh_smpl, label_smpl, 'pants', 20);
% save([result_dir, filesep, mesh_prefix, '_pose_pants.mat'], 'pose_pants');
    
% combine all garments to one;
m_comined = mesh_smpl;
m_comined.vertices(garments_smpl.shirt.vertices_ind, :) = vertices_shirt;
m_comined.vertices(garments_smpl.pants.vertices_ind, :) = vertices_pants;
mesh_exporter([result_dir, filesep, mesh_prefix, ...
    '_combined_full.obj'], m_comined, true);

% for full mesh
% [vertices_all, pose] = align_cloth(garments_scan, garments_smpl, ...
%     mesh_scan, mesh_combined, label_smpl);
% save([result_dir, filesep, mesh_prefix, '_pose_pants.mat'], 'pose');

end