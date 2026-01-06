# Transformer 架构
Transformer 是一种基于“自注意力（Self-Attention）”机制的深度学习模型结构，最早由 Google 在 2017 年论文《[Attention Is All You Need](https://arxiv.org/abs/1706.03762)》中提出。
（中文解读汇总 https://www.cnblogs.com/Harukaze/p/15100938.html）
(AI论文精读 https://www.cnblogs.com/deeplink/p/18821902)
(通俗解读 https://www.toutiao.com/article/7551265196153504282/?source=m_redirect&wid=1767684295642)

它彻底抛弃了传统 RNN/CNN 的序列或局部建模方式，完全依靠注意力机制并行地捕捉输入序列中任意两个位置之间的依赖关系，从而在大规模语料上实现更高效、更优质的语言建模。

核心组件  
1. 多头自注意力（Multi-Head Self-Attention）  
   将输入向量映射到多个子空间，并行计算注意力权重，再拼接输出，增强模型对不同语义关系的捕获能力。  

2. 位置编码（Positional Encoding）  
   由于 Transformer 本身不含递归或卷积，需要额外加入位置信息，使模型感知 token 在序列中的先后顺序。  

3. 前馈全连接层（Position-wise Feed-Forward Network）  
   对每个位置独立地进行两次线性变换 + 激活，进一步提取特征。  

4. 残差连接与层归一化（Residual Connection & Layer Normalization）  
   缓解深层网络梯度消失问题，加速收敛。  

5. 编码器-解码器架构（Encoder-Decoder）  
   编码器将输入序列编码成上下文向量序列；解码器在生成输出时，既能关注编码器输出，也能关注已生成的部分，实现序列到序列的任务（如机器翻译）。  

优点  
• 并行度高：无需按时间步递归，可一次性处理整个序列，训练速度显著快于 RNN。  
• 长距离依赖建模能力强：自注意力直接连接任意两个位置，解决 RNN 的长程梯度衰减问题。  
• 可扩展性好：通过简单堆叠层数、增加头数即可扩大模型容量，诞生出 GPT、BERT、T5、PaLM 等大规模预训练模型。  

应用  
Transformer 已成为自然语言处理（NLP）的通用骨架，被广泛用于：  
• 预训练语言模型：BERT（双向编码）、GPT（自回归解码）、T5（Text-to-Text）。  
• 机器翻译、文本摘要、对话系统、搜索引擎、代码生成。  
• 跨模态任务：Vision Transformer（ViT）将图像切块当序列，实现图像分类、目标检测；CLIP 融合图文，实现零样本识别。  

一句话总结  
Transformer 用“注意力”取代“递归/卷积”，让模型在训练时看得更远、跑得更快、变得更大，从而开启了现代大模型时代。

# 基于 Attention 的 Seq2Seq 模型
Seq2Seq 模型是一种基于 Encoder-Decoder 架构的序列到序列模型，用于将输入序列映射到输出序列。它通常用于机器翻译、文本摘要、对话系统等任务。

# BLEU分数
BLEU（Bilingual Evaluation Understudy）分数是一种用于评估机器翻译质量的指标，由 IBM 于 2002 年提出。它基于 n-gram 匹配率，考虑了翻译结果与参考翻译的重叠度和流畅度。

BLEU 分数的计算步骤如下：
1. 计算 n-gram 匹配率：统计翻译结果中与参考翻译重叠的 n-gram 数量，除以翻译结果的总 n-gram 数量。
2. 计算几何平均值：将所有 n-gram 匹配率取指数加权平均，权重为 1/n。
3. 考虑长度惩罚：如果翻译结果较短，会给几何平均值乘上一个惩罚因子，以惩罚较短的翻译。

BLEU 分数的取值范围在 0 到 1 之间，越接近 1 表示翻译结果越接近参考翻译，质量越好。
