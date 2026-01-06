# 源起
2016.1.6 想搜索一下transformer的论文,因为最近刚接触TRAE,觉得这是一个很神奇的工具,就试着在这里探索一下答案！

# BigModels 笔记大纲

## 1. 概述
- 定义：大模型（Big Models）指参数量巨大、训练数据海量、计算资源需求高的深度学习模型。
- 代表：GPT 系列、PaLM、LLaMA、BERT、T5、ChatGLM 等。

## 2. 技术演进
- Transformer 架构 → 自注意力机制
- 预训练 + 微调范式
- 参数扩展：亿级 → 百亿级 → 千亿级 → 万亿级
- 多模态融合：文本、图像、音频、视频

## 3. 训练方法
- 预训练（Pre-training）
  - 无监督/自监督目标：MLM、CLM、Span Corruption
- 微调（Fine-tuning）
  - 全参数微调
  - 参数高效微调：LoRA、AdaLoRA、QLoRA、Prompt Tuning、P-tuning v2
- 对齐（Alignment）
  - RLHF：Reinforcement Learning from Human Feedback
  - DPO：Direct Preference Optimization
  - RLAIF：AI Feedback 替代人类反馈

## 4. 推理优化
- 量化：INT8/INT4/FP16/FP8
- 剪枝：结构化 / 非结构化
- 蒸馏：Teacher → Student
- 并行策略：数据并行、模型并行、流水线并行、张量并行
- 推理框架：vLLM、TensorRT-LLM、DeepSpeed-Inference、Text Generation Inference (TGI)

## 5. 应用场景
- 自然语言处理：对话、翻译、摘要、问答、代码生成
- 多模态：图文生成、视频理解、语音合成
- 行业落地：金融、医疗、教育、法律、电商、游戏

## 6. 挑战与风险
- 算力与能耗
- 数据版权与隐私
- 幻觉（Hallucination）
- 偏见与毒性
- 可解释性与可控性
- 法规合规：中国《生成式 AI 管理办法》、欧盟 AI Act

## 7. 未来趋势
- 稀疏大模型（MoE）
- 长上下文（1M+ tokens）
- 自主智能体（Agent）
- 具身智能（Embodied AI）
- 低成本个人化大模型

===========================================================================================
