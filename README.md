Lambda CI/CD サンプル セミオートトラフィックコントロール
====

## Description
CodePipelineを利用して CodeCommit → CodeBuild → CodeDeploy の流れでLambdaを更新するサンプル  
Lambdaを単純に書き換えるだけでLambdaのバージョン管理やAPIGatewayとの間でAliasを使ったバージョン指定などは行なっていない  
そのため、トラフィックのコントロールは実装者に委ねられる

## Install
### Preparation
cfn/_variable.shを自分のインストールしたい環境の設定に合わせて編集する

### Create Resource
```
$ cd /PATH/TO/THIS
$ sh ./cfn/_deploy.sh
```
サンプル環境を用意する  

## Usage
### サンプルコードをCodeCommitにプッシュ
```
$ cd /PATH/TO/THIS
$ git remote add origin ssh://git-codecommit.{$AWS_DEFAULT_REGION}.amazonaws.com/v1/repos/{$NAME}-{$STAGE}
$ git add .
$ git commit -m "first commit"
$ git push origin master
```
これでmasterへのコードの変更を起点としてCodePipeline({$NAME}-{$STAGE}-pipeline)が動き出す  

## Uninstall
```
$ cd /PATH/TO/THIS
$ sh ./cfn/_remove.sh
```  

## Limitations
- CFnのファイルにLambdaのコードを書いているのでpyファイルの名称はindex.py固定になるが実運用ではそんなことはありえないのでCFnを細分化したり事前に別のS3にコード置くなり仕掛けが必要

## Versioning
バージョンはv1.2.3という形でtagを付けることにより管理する  
v: 接頭辞として固定  
1: メジャバージョン  
2: マイナバージョン  
3: ビルドバージョン  
masterに 修正が加えられる毎にビルドバージョンを増加  
後方互換性がない修正が入る場合にはマイナバージョンを増加させて、ビルドバージョンは0にリセットする  

## Contribution
- Fork it
- Create your feature branch (git checkout -b my-new-feature)
- Commit your changes (git commit -am 'Add some feature')
- Push to the branch (git push origin my-new-feature)
- Create new Pull Request
