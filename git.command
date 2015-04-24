git init

git add/git commit -m 'xx'

git diff file

git log [--pretty=oneline]

##版本回退到某一个
git reset --hard HEAD^|HEAD^^|HEAD~100|commit_id

##查看每次命令,查找最近的commit_id,重新回到最近的commit
git reflog

git checkout -- readme.txt意思就是，把readme.txt文件在工作区的修改全部撤销，这里有两种情况：
一种是readme.txt自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
一种是readme.txt已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
git checkout -- file命令中的--很重要，没有--，就变成了“创建一个新分支”的命令

git reset HEAD file可以把暂存区的修改撤销掉（unstage），重新放回工作区
git reset命令既可以回退版本，也可以把暂存区的修改回退到工作区。当我们用HEAD时，表示最新的版本。

                  add ---->                 commit---->
working area                      index                      repository
            <--- checkout --file         <----reset HEAD file


git rm删掉，并且git commit

git remote add origin git@github.com:XuJingnan/learngit.git
git push -u origin master
此后，每次本地提交后，只要有必要，就可以使用命令git push origin master推送最新修改

要克隆一个仓库，首先必须知道仓库的地址，然后使用git clone命令克隆。


**********************************************

HEAD严格来说不是指向提交，而是指向master，master才是指向提交的，所以，HEAD指向的就是当前分支。

创建dev分支，然后切换到dev分支：
git checkout -b dev
git checkout命令加上-b参数表示创建并切换，相当于以下两条命令：
$ git branch dev
$ git checkout dev

用git branch命令查看当前分支：
$ git branch

现在，dev分支的工作完成，我们就可以切换回master分支：
$ git checkout master
把dev分支的工作成果合并到master分支上：
$ git merge dev
git merge命令用于合并指定分支到当前分支。

合并完成后，就可以放心地删除dev分支了：
$ git branch -d dev

查看分支：git branch

创建分支：git branch <name>

切换分支：git checkout <name>

创建+切换分支：git checkout -b <name>

合并某分支到当前分支：git merge <name>

删除分支：git branch -d <name>

用带参数的git log也可以看到分支的合并情况：
git log --graph --pretty=oneline --abbrev-commit

如果要强制禁用Fast forward模式，Git就会在merge时生成一个新的commit，这样，从分支历史上就可以看出分支信息。
git merge --no-ff -m 'merge with no-ff' dev 

强行删除分支：
$ git branch -D feature-vulcan

*******************************************************


Git还提供了一个stash功能，可以把当前工作现场“储藏”起来，等以后恢复现场后继续工作：
$ git stash
刚才的工作现场存到哪去了？用git stash list命令看看：
$ git stash list

恢复一下，有两个办法：
一是用git stash apply恢复，但是恢复后，stash内容并不删除，你需要用git stash drop来删除；
另一种方式是用git stash pop，恢复的同时把stash内容也删了：

你可以多次stash，恢复的时候，先用git stash list查看，然后恢复指定的stash，用命令：
$ git stash apply stash@{0}

*********************************************************
要查看远程库的信息，用git remote：
$ git remote
origin

或者，用git remote -v显示更详细的信息：
$ git remote -v
origin  git@github.com:michaelliao/learngit.git (fetch)
origin  git@github.com:michaelliao/learngit.git (push)

推送分支
推送分支，就是把该分支上的所有本地提交推送到远程库。推送时，要指定本地分支，这样，Git就会把该分支推送到远程库对应的远程分支上：

$ git push origin master

如果要推送其他分支，比如dev，就改成：

$ git push origin dev

抓取分支
多人协作时，大家都会往master和dev分支上推送各自的修改。

当你的小伙伴从远程库clone时，默认情况下，你的小伙伴只能看到本地的master分支。不信可以用git branch命令看看：
$ git branch
* master

现在，你的小伙伴要在dev分支上开发，就必须创建远程origin的dev分支到本地，于是他用这个命令创建本地dev分支：

$ git checkout -b dev origin/dev
$ git push origin dev

推送失败，因为你的小伙伴的最新提交和你试图推送的提交有冲突，解决办法也很简单，Git已经提示我们，先用git pull把最新的提交从origin/dev抓下来，然后，在本地合并，解决冲突，再推送：

$ git pull

git pull也失败了，原因是没有指定本地dev分支与远程origin/dev分支的链接，根据提示，设置dev和origin/dev的链接：

$ git branch --set-upstream dev origin/dev

再pull：

$ git pull

这回git pull成功，但是合并有冲突，需要手动解决，解决的方法和分支管理中的解决冲突完全一样。解决后，提交，再push

因此，多人协作的工作模式通常是这样：

    首先，可以试图用git push origin branch-name推送自己的修改；

    如果推送失败，则因为远程分支比你的本地更新，需要先用git pull试图合并；

    如果合并有冲突，则解决冲突，并在本地提交；

    没有冲突或者解决掉冲突后，再用git push origin branch-name推送就能成功！

如果git pull提示“no tracking information”，则说明本地分支和远程分支的链接关系没有创建，用命令git branch --set-upstream branch-name origin/branch-name。

这就是多人协作的工作模式，一旦熟悉了，就非常简单。

若要查看各个分支最后一个提交对象的信息，运行 git branch -v
要从该清单中筛选出你已经（或尚未）与当前分支合并的分支，可以用 --merged 和 --no-merged 选项

