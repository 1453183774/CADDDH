mainfile = uigetdir
maindir = dir(mainfile);

dicomPath = 'E:\\�Źؽ�\\SaveDicom';
textPath = 'E:\\�Źؽ�\\Text';
jpg1Path = 'E:\�Źؽ�\jpg1Path';
jpg2Path = 'E:\�Źؽ�\jpg2Path';

len = length(maindir);
k=1;
while(k<=len)
    if(isequal(maindir(k).name,'.')||... % ȥ��ϵͳ�Դ����������ļ���
          isequal(maindir(k).name,'..'))
        k=k+1;
        continue;
    end
    userfile = fullfile(mainfile,'\',maindir(k).name);
    if(isfolder(userfile))
        userid = maindir(k).name;
        %fprintf('%s\n',userid);
        finddicom(userfile,userid);
        k = k + 1;
        continue;
    end
    k = k+1;
end

function finddicom(x,y)
%x��·��
%ʹ�õݹ鷽������
%����xĿ¼�µ��ļ����ļ�������������Ǹ��ļ����ӡ·��\
    dirx = dir(x);
    for i=1:length(dirx)
        if(isequal(dirx(i).name,'.')||... % ȥ��ϵͳ�Դ����������ļ���
          isequal(dirx(i).name,'..'))
            continue;
        end
        subfile = fullfile(x,'\',dirx(i).name);
        if(isfolder(subfile))
            finddicom(subfile,y);
            continue;
        end
        if(~isfolder(subfile))
            if(isequal(dirx(i).name,'I1000000'))
                fprintf('%s\t',subfile);
                fprintf('%s\n',y);
                dicomPath = 'E:\\�Źؽ�\\SaveDicom\\';
                textPath = 'E:\\�Źؽ�\\Text\';
                jpg1Path = 'E:\�Źؽ�\jpg1Path\';
                jpg2Path = 'E:\�Źؽ�\jpg2Path\';
                processDicom(subfile,y,dicomPath,textPath,jpg1Path,jpg2Path);
                continue;
            end
        end
    end
end

