# My-research
**Variable Selection in D-learning for ITR**

📜 **석사 졸업 논문에서 패키지를 쓰지 않고 직접 개발한 D-learning 알고리즘 코드입니다. 기존의 방법론에 Convex penalty(Elastin net) 과 Nonconvex penalty(SCAD, MCP) 기법을 접목하여 차별화하였습니다.**



<br/> 
(초록)

최적의 개별 치료 규칙(ITR)은 개별 연구대상의 특성을 기반으로 개인별 최적의 처방을 제안하는 의사 결정 함수이다. 기존의 모델 기반 또는 분류 기반 ITR 방법론은 예측 시 모델 또는 가중치 설정에서 오류가 발생할 가능성이 존재한다. D-learning 방 법론은 직접적으로 최적의 ITR을 추정함으로써 이러한 문제를 해결한다. 또한, 최적의 ITR 추정에서는 의사 결정 규칙에 관여하는 규칙 변수를 추출하는 것이 핵심 부분이 다. 본 논문에서는 D-learning 방법론과 볼록 및 비볼록 벌점 함수를 포함한 변수 선택 기법의 접목을 제안한다. 이를 통해 ITR 추정 시 예측 정확도를 향상시키고, 의사 결 정 규칙의 해석력을 개선하고자 한다. 모의실험 및 실제 데이터의 분석에서 기존의 방법과 제안된 방법 간의 비교를 통해 향상된 성능을 입증하였다.


<br/>
(Abstract)

The optimal individualized treatment regimes (ITR) involves a decision function that maximizes the expected clinical outcome by considering individual patient character- istics. However, existing model-based or classification-based methods for ITR are sus- ceptible to potential errors in model specification or weight assignment. To address this concern, D-learning method has been developed to directly estimate the optimal ITR. In optimization of ITR, it is crucial to select important prescriptive variables that have a role in the decision rule and interact with the treatment. In this paper, we propose incorporating a range of variable selection techniques, including both convex and non- convex penalty functions into D-learning. Through simulations and analysis of real data, we demonstrate that our proposed method exhibits promising performance compared to existing method.







