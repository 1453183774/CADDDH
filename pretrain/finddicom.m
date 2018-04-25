function [ result ] = finddicom( x,y )
%x��·��
%ʹ�õݹ鷽������
%����xĿ¼�µ��ļ����ļ�������������Ǹ��ļ����ӡ·��\
    dirx = dir(x);
    for i=1:length(dirx)
        if(isequal(dirx(i).name,'.')||isequal(dirx(i).name,'..')) % ȥ��ϵͳ�Դ����������ļ���
            continue;
        end
        subfile = fullfile(x,'\',dirx(i).name);
        if(isdir(subfile))
            finddicom(subfile,y);
            continue;
        end
        if(~isdir(subfile))
            if~(isequal(dirx(i).name,'DICOMDIR')||isequal(dirx(i).name,'LOCKFILE')||isequal(dirx(i).name,'VERSION'))
                fprintf('%s\t',subfile);
                fprintf('%s\n',y);
                processDicom(subfile,y);
                continue;
            end
        end
    end

end

