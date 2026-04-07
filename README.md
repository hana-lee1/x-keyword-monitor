# 🔍 X 키워드 모니터

> X(트위터)에서 지정 키워드의 트윗을 자동 수집하고, 대시보드로 인기 트윗을 한눈에 확인하는 시스템입니다.

## ✨ 주요 기능

- **트윗 수집**: X에서 키워드별 인기 트윗 자동 크롤링 (매일 23:00)
- **스레드 수집**: Top 5 인기 트윗의 답글 스레드 자동 수집
- **대시보드**: [dashboard.html](https://hana-lee1.github.io/x-keyword-monitor/dashboard.html) — 수집된 트윗 목록, 최근 7일 RT 기준 Top 5, 키워드별 필터, 시간대별 차트

---

## 📋 사전 준비 (API 키 발급)

### X (Twitter) API 키
1. [X Developer Portal](https://developer.x.com/en/portal/dashboard) 접속
2. **Projects & Apps** → **+ Create App**
3. **Keys and tokens** 탭에서 **Bearer Token** 복사

### Supabase
1. [Supabase](https://supabase.com) 프로젝트 생성
2. `setup_all_tables.sql`을 SQL Editor에서 실행
3. **Project URL**과 **anon key** 복사

---

## 🔧 설치 방법

```bash
git clone https://github.com/hana-lee1/x-keyword-monitor.git
cd x-keyword-monitor
pip3 install -r requirements.txt --break-system-packages
cp .env.example .env
nano .env  # X_BEARER_TOKEN, SUPABASE_URL, SUPABASE_KEY 입력
```

---

## 📌 사용법

| 명령어 | 설명 |
|:-------|:-----|
| `python3 collect_tweets.py` | 전체 키워드 수집 + Top 5 스레드 수집 |
| `python3 collect_tweets.py add 공부팁` | 키워드 추가 |
| `python3 collect_tweets.py remove 공부팁` | 키워드 비활성화 |
| `python3 collect_tweets.py delete 공부팁` | 키워드 + 트윗 완전 삭제 |
| `python3 collect_tweets.py list` | 키워드 목록 |
| `python3 collect_tweets.py threads` | Top 5 스레드만 수집 |

### 대시보드
[https://hana-lee1.github.io/x-keyword-monitor/dashboard.html](https://hana-lee1.github.io/x-keyword-monitor/dashboard.html)

---

## ⏰ 자동 실행 스케줄

| 시간 | 작업 |
|:----:|:-----|
| 23:00 | 트윗 수집 (크롤링) |

> 💡 Mac 잠자기 모드에서는 자동 실행 안 됨. **시스템 설정 → 에너지 → 네트워크 액세스를 위해 깨우기** 켜기

---

## ❓ 문제 해결

- **403 Forbidden / spend cap 도달** → X Developer Portal에서 Spend Cap 증액
- **ModuleNotFoundError** → `pip3 install -r requirements.txt --break-system-packages`

---

## 📁 파일 구조
```
x-keyword-monitor/
├── .env                    # API 키 (공유 금지!)
├── collect_tweets.py       # X 트윗 수집기
├── dashboard.html          # 대시보드 (수집 트윗, Top 5)
├── setup_all_tables.sql    # Supabase 테이블 스키마
├── setup.sh                # 설치 스크립트
├── requirements.txt        # Python 의존성
└── cron.log                # 실행 로그
```
