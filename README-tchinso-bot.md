# 트친소 자동 좋아요 + 맞팔로우 봇

`#공부계_트친소` `#공부계트친소` 해시태그에 올라오는 트윗에 자동으로 좋아요를 누르고,
나를 팔로우한 유저에게 맞팔로우를 해주는 봇입니다.

X 공식 API v2를 사용하므로 계정 정지 위험이 없습니다.

---

## 시작하기 (5분이면 끝!)

### 1단계: X API 키 발급

1. [X Developer Portal](https://developer.x.com/en/portal/dashboard) 접속
2. **앱 생성** (Free 플랜 OK)
3. 앱 설정 → **User authentication settings** → **Read and Write** 권한 설정
4. 아래 5개 키를 메모:

| 키 이름 | 어디서 찾나요? |
|---------|--------------|
| `X_API_KEY` | App > Keys and tokens > API Key |
| `X_API_SECRET` | App > Keys and tokens > API Key Secret |
| `X_BEARER_TOKEN` | App > Keys and tokens > Bearer Token |
| `X_ACCESS_TOKEN` | App > Keys and tokens > Access Token |
| `X_ACCESS_TOKEN_SECRET` | App > Keys and tokens > Access Token Secret |

> ⚠️ **중요:** Access Token은 반드시 **Read and Write** 권한으로 생성해야 합니다.
> 권한을 바꿨다면 토큰을 **재생성**해야 적용됩니다.

### 2단계: 설치 & 실행

```bash
# 이 폴더로 이동
cd 이_폴더_경로

# 자동 설치 (API 키 입력 포함)
bash setup_x_follower.sh
```

setup_x_follower.sh가 하는 일:
- Python 설치 여부 확인
- 필요한 패키지 자동 설치
- API 키 입력 받아서 `.env` 파일 자동 생성
- dry-run 테스트 실행
- (선택) 매일 아침 8시 자동 실행 등록

---

## 수동 실행

```bash
# 좋아요 + 맞팔로우 (기본)
python3 like_tchinso.py

# 테스트만 (실제 좋아요 안 누름)
python3 like_tchinso.py --dry-run

# 좋아요만
python3 like_tchinso.py --like-only

# 맞팔로우만
python3 like_tchinso.py --follow-only
```

---

## 설정 변경

`like_tchinso.py` 파일 상단에서 수정 가능:

```python
HASHTAGS = ["#공부계_트친소", "#공부계트친소"]  # 검색할 해시태그
MAX_LIKES_PER_RUN = 50       # 하루 최대 좋아요 개수
MAX_FOLLOWS_PER_RUN = 15     # 하루 최대 맞팔로우 개수
LOG_RETENTION_DAYS = 7       # 좋아요 기록 보관 기간
```

---

## 파일 구조

```
├── like_tchinso.py      # 메인 봇 스크립트
├── setup_x_follower.sh             # 원클릭 설치 스크립트
├── requirements.txt     # Python 패키지 목록
├── .env.example         # API 키 템플릿
├── .env                 # 내 API 키 (setup_x_follower.sh가 자동 생성)
├── .liked_tchinso.json  # 좋아요 기록 (자동 생성, 건드리지 마세요)
└── like_tchinso.log     # 실행 로그 (cron 등록 시 자동 생성)
```

---

## 자주 묻는 질문

**Q: Free 플랜으로 되나요?**
A: 네! X API Free 플랜으로 충분합니다. 단, 월 1,500 트윗 읽기 제한이 있어서 하루 50개 좋아요면 넉넉합니다.

**Q: 계정 정지 안 되나요?**
A: 공식 API를 사용하고, 좋아요 간 2초 간격 + 하루 50개 제한이라 안전합니다.

**Q: 해시태그를 바꾸고 싶어요**
A: `like_tchinso.py` 상단의 `HASHTAGS` 리스트를 수정하세요.
