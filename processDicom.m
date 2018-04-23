function [ result ] = processDicom( path,labeler,dicom_path,txt_path,jpg1_path,jpg2_path,window_width,window_center )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    img = dicomread(path);   %��ȡͼ��
	dcm = dicominfo(path);%�洢��Ϣ
    if(nargin<8)
        if(nargin<6)
            result = -1;
            return;
        end
        window_width = dcm.WindowWidth;
        window_center = dcm.WindowCenter;
    end
    if strcmp(dicom_path(end),'\')||strcmp(dicom_path(end),'\')
        dicom_path = [dicom_path,'\'];
    end
    if strcmp(txt_path(end),'\')||strcmp(txt_path(end),'\')
        txt_path = [txt_path,'\'];
    end
    if strcmp(jpg1_path(end),'\')||strcmp(jpg1_path(end),'\')
        jpg1_path = [jpg1_path,'\'];
    end
    if strcmp(jpg2_path(end),'\')||strcmp(jpg2_path(end),'\')
        jpg2_path = [jpg2_path,'\'];
    end
    
    uid = dcm.SOPInstanceUID;
    copyfile(path,[dicom_path,labeler,'_',uid,'.dcm']);
    img = double(img);
    img = (img-window_center+0.5*window_width)/window_width*255;
    img = uint8(img);
    image=figure;
    imshow(img);%��ʾԭͼͼ��
    saveas(image,[jpg1_path,labeler,'_',uid,'.jpg']);
    hold on;
    try
        data1 = dcm.CurveData_0;
        data2 = dcm.CurveData_2;
        data3 = dcm.CurveData_4;
        data = {data1 data2 data3};
    catch
        result = -2;
        return;
    end
    str_txt = [];
    for j = 1:1:3
        data_current = data{j};
        if size(data_current,1)==12
            for i = 4:-1:1
                plot(data_current(i*2-1),data_current(i*2),'ro','linewidth',2);
                str_txt = [num2str(data_current(i*2-1)),' ',num2str(data_current(i*2)),' ',str_txt];
            end
        elseif size(data_current,1)==8
            for i = 1:2:5
                line([data_current(i),data_current(i+2)],[data_current(i+1),data_current(i+3)],'linewidth',2,'color','b');
            end
            line([data_current(1),data_current(7)],[data_current(2),data_current(8)],'linewidth',2,'color','b');
            str_txt = [str_txt,num2str(data_current(1)),' ',num2str(data_current(2)),' ',num2str(data_current(5)),' ',num2str(data_current(6)),' '];
        else
            result = -3;
            return;
        end
    end
    saveas(image,[jpg2_path,labeler,'_',uid,'.jpg']);
    f_txt = fopen([txt_path,labeler,'_',uid,'.txt'],'a');
    fprintf(f_txt,'%s\r\n',str_txt);
    fclose(f_txt);
    result = 0;
    
%%line([dcm5.CurveData_0(1) dcm5.CurveData_0(2)],[dcm5.CurveData_0(3) dcm5.CurveData_0(4)],'color','r','LineWidth',5);
% for i = 1:1:6
%     plot(dcm5.CurveData_0(i*2-1),dcm5.CurveData_0(i*2),'ro');
% end
%  for i = 1:1:4
%      plot(dcm6.CurveData_2(i*2-1),dcm6.CurveData_2(i*2),'bo');
%      plot(dcm6.CurveData_4(i*2-1),dcm6.CurveData_4(i*2),'bo');
%  end
%  plot(dcm6.CurveData_6(1),dcm6.CurveData_6(2),'yo');
%  plot(dcm6.CurveData_8(1),dcm6.CurveData_8(2),'yo');

end

