
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "../kernel/types.h"
#include "user.h"

int main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84ae                	mv	s1,a1
	if (argc==1){
   c:	4785                	li	a5,1
   e:	02f50363          	beq	a0,a5,34 <main+0x34>
		printf("Did you forget the argument?\n");
	}
	else if (argc>2){
  12:	4789                	li	a5,2
  14:	02a7c963          	blt	a5,a0,46 <main+0x46>
		printf("Please only pass one value.\n");
	}

	int seconds = atoi(argv[1]);
  18:	6488                	ld	a0,8(s1)
  1a:	00000097          	auipc	ra,0x0
  1e:	1ca080e7          	jalr	458(ra) # 1e4 <atoi>
	sleep(seconds);
  22:	00000097          	auipc	ra,0x0
  26:	34c080e7          	jalr	844(ra) # 36e <sleep>
	exit (0);
  2a:	4501                	li	a0,0
  2c:	00000097          	auipc	ra,0x0
  30:	2b2080e7          	jalr	690(ra) # 2de <exit>
		printf("Did you forget the argument?\n");
  34:	00000517          	auipc	a0,0x0
  38:	7cc50513          	addi	a0,a0,1996 # 800 <malloc+0xf0>
  3c:	00000097          	auipc	ra,0x0
  40:	61c080e7          	jalr	1564(ra) # 658 <printf>
  44:	bfd1                	j	18 <main+0x18>
		printf("Please only pass one value.\n");
  46:	00000517          	auipc	a0,0x0
  4a:	7da50513          	addi	a0,a0,2010 # 820 <malloc+0x110>
  4e:	00000097          	auipc	ra,0x0
  52:	60a080e7          	jalr	1546(ra) # 658 <printf>
  56:	b7c9                	j	18 <main+0x18>

0000000000000058 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  58:	1141                	addi	sp,sp,-16
  5a:	e406                	sd	ra,8(sp)
  5c:	e022                	sd	s0,0(sp)
  5e:	0800                	addi	s0,sp,16
  extern int main();
  main();
  60:	00000097          	auipc	ra,0x0
  64:	fa0080e7          	jalr	-96(ra) # 0 <main>
  exit(0);
  68:	4501                	li	a0,0
  6a:	00000097          	auipc	ra,0x0
  6e:	274080e7          	jalr	628(ra) # 2de <exit>

0000000000000072 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  72:	1141                	addi	sp,sp,-16
  74:	e422                	sd	s0,8(sp)
  76:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  78:	87aa                	mv	a5,a0
  7a:	0585                	addi	a1,a1,1
  7c:	0785                	addi	a5,a5,1
  7e:	fff5c703          	lbu	a4,-1(a1)
  82:	fee78fa3          	sb	a4,-1(a5)
  86:	fb75                	bnez	a4,7a <strcpy+0x8>
    ;
  return os;
}
  88:	6422                	ld	s0,8(sp)
  8a:	0141                	addi	sp,sp,16
  8c:	8082                	ret

000000000000008e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e422                	sd	s0,8(sp)
  92:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  94:	00054783          	lbu	a5,0(a0)
  98:	cb91                	beqz	a5,ac <strcmp+0x1e>
  9a:	0005c703          	lbu	a4,0(a1)
  9e:	00f71763          	bne	a4,a5,ac <strcmp+0x1e>
    p++, q++;
  a2:	0505                	addi	a0,a0,1
  a4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a6:	00054783          	lbu	a5,0(a0)
  aa:	fbe5                	bnez	a5,9a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  ac:	0005c503          	lbu	a0,0(a1)
}
  b0:	40a7853b          	subw	a0,a5,a0
  b4:	6422                	ld	s0,8(sp)
  b6:	0141                	addi	sp,sp,16
  b8:	8082                	ret

00000000000000ba <strlen>:

uint
strlen(const char *s)
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e422                	sd	s0,8(sp)
  be:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	cf91                	beqz	a5,e0 <strlen+0x26>
  c6:	0505                	addi	a0,a0,1
  c8:	87aa                	mv	a5,a0
  ca:	4685                	li	a3,1
  cc:	9e89                	subw	a3,a3,a0
  ce:	00f6853b          	addw	a0,a3,a5
  d2:	0785                	addi	a5,a5,1
  d4:	fff7c703          	lbu	a4,-1(a5)
  d8:	fb7d                	bnez	a4,ce <strlen+0x14>
    ;
  return n;
}
  da:	6422                	ld	s0,8(sp)
  dc:	0141                	addi	sp,sp,16
  de:	8082                	ret
  for(n = 0; s[n]; n++)
  e0:	4501                	li	a0,0
  e2:	bfe5                	j	da <strlen+0x20>

00000000000000e4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e4:	1141                	addi	sp,sp,-16
  e6:	e422                	sd	s0,8(sp)
  e8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ea:	ca19                	beqz	a2,100 <memset+0x1c>
  ec:	87aa                	mv	a5,a0
  ee:	1602                	slli	a2,a2,0x20
  f0:	9201                	srli	a2,a2,0x20
  f2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fa:	0785                	addi	a5,a5,1
  fc:	fee79de3          	bne	a5,a4,f6 <memset+0x12>
  }
  return dst;
}
 100:	6422                	ld	s0,8(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strchr>:

char*
strchr(const char *s, char c)
{
 106:	1141                	addi	sp,sp,-16
 108:	e422                	sd	s0,8(sp)
 10a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10c:	00054783          	lbu	a5,0(a0)
 110:	cb99                	beqz	a5,126 <strchr+0x20>
    if(*s == c)
 112:	00f58763          	beq	a1,a5,120 <strchr+0x1a>
  for(; *s; s++)
 116:	0505                	addi	a0,a0,1
 118:	00054783          	lbu	a5,0(a0)
 11c:	fbfd                	bnez	a5,112 <strchr+0xc>
      return (char*)s;
  return 0;
 11e:	4501                	li	a0,0
}
 120:	6422                	ld	s0,8(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret
  return 0;
 126:	4501                	li	a0,0
 128:	bfe5                	j	120 <strchr+0x1a>

000000000000012a <gets>:

char*
gets(char *buf, int max)
{
 12a:	711d                	addi	sp,sp,-96
 12c:	ec86                	sd	ra,88(sp)
 12e:	e8a2                	sd	s0,80(sp)
 130:	e4a6                	sd	s1,72(sp)
 132:	e0ca                	sd	s2,64(sp)
 134:	fc4e                	sd	s3,56(sp)
 136:	f852                	sd	s4,48(sp)
 138:	f456                	sd	s5,40(sp)
 13a:	f05a                	sd	s6,32(sp)
 13c:	ec5e                	sd	s7,24(sp)
 13e:	1080                	addi	s0,sp,96
 140:	8baa                	mv	s7,a0
 142:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 144:	892a                	mv	s2,a0
 146:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 148:	4aa9                	li	s5,10
 14a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 14c:	89a6                	mv	s3,s1
 14e:	2485                	addiw	s1,s1,1
 150:	0344d863          	bge	s1,s4,180 <gets+0x56>
    cc = read(0, &c, 1);
 154:	4605                	li	a2,1
 156:	faf40593          	addi	a1,s0,-81
 15a:	4501                	li	a0,0
 15c:	00000097          	auipc	ra,0x0
 160:	19a080e7          	jalr	410(ra) # 2f6 <read>
    if(cc < 1)
 164:	00a05e63          	blez	a0,180 <gets+0x56>
    buf[i++] = c;
 168:	faf44783          	lbu	a5,-81(s0)
 16c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 170:	01578763          	beq	a5,s5,17e <gets+0x54>
 174:	0905                	addi	s2,s2,1
 176:	fd679be3          	bne	a5,s6,14c <gets+0x22>
  for(i=0; i+1 < max; ){
 17a:	89a6                	mv	s3,s1
 17c:	a011                	j	180 <gets+0x56>
 17e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 180:	99de                	add	s3,s3,s7
 182:	00098023          	sb	zero,0(s3)
  return buf;
}
 186:	855e                	mv	a0,s7
 188:	60e6                	ld	ra,88(sp)
 18a:	6446                	ld	s0,80(sp)
 18c:	64a6                	ld	s1,72(sp)
 18e:	6906                	ld	s2,64(sp)
 190:	79e2                	ld	s3,56(sp)
 192:	7a42                	ld	s4,48(sp)
 194:	7aa2                	ld	s5,40(sp)
 196:	7b02                	ld	s6,32(sp)
 198:	6be2                	ld	s7,24(sp)
 19a:	6125                	addi	sp,sp,96
 19c:	8082                	ret

000000000000019e <stat>:

int
stat(const char *n, struct stat *st)
{
 19e:	1101                	addi	sp,sp,-32
 1a0:	ec06                	sd	ra,24(sp)
 1a2:	e822                	sd	s0,16(sp)
 1a4:	e426                	sd	s1,8(sp)
 1a6:	e04a                	sd	s2,0(sp)
 1a8:	1000                	addi	s0,sp,32
 1aa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ac:	4581                	li	a1,0
 1ae:	00000097          	auipc	ra,0x0
 1b2:	170080e7          	jalr	368(ra) # 31e <open>
  if(fd < 0)
 1b6:	02054563          	bltz	a0,1e0 <stat+0x42>
 1ba:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1bc:	85ca                	mv	a1,s2
 1be:	00000097          	auipc	ra,0x0
 1c2:	178080e7          	jalr	376(ra) # 336 <fstat>
 1c6:	892a                	mv	s2,a0
  close(fd);
 1c8:	8526                	mv	a0,s1
 1ca:	00000097          	auipc	ra,0x0
 1ce:	13c080e7          	jalr	316(ra) # 306 <close>
  return r;
}
 1d2:	854a                	mv	a0,s2
 1d4:	60e2                	ld	ra,24(sp)
 1d6:	6442                	ld	s0,16(sp)
 1d8:	64a2                	ld	s1,8(sp)
 1da:	6902                	ld	s2,0(sp)
 1dc:	6105                	addi	sp,sp,32
 1de:	8082                	ret
    return -1;
 1e0:	597d                	li	s2,-1
 1e2:	bfc5                	j	1d2 <stat+0x34>

00000000000001e4 <atoi>:

int
atoi(const char *s)
{
 1e4:	1141                	addi	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ea:	00054683          	lbu	a3,0(a0)
 1ee:	fd06879b          	addiw	a5,a3,-48
 1f2:	0ff7f793          	zext.b	a5,a5
 1f6:	4625                	li	a2,9
 1f8:	02f66863          	bltu	a2,a5,228 <atoi+0x44>
 1fc:	872a                	mv	a4,a0
  n = 0;
 1fe:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 200:	0705                	addi	a4,a4,1
 202:	0025179b          	slliw	a5,a0,0x2
 206:	9fa9                	addw	a5,a5,a0
 208:	0017979b          	slliw	a5,a5,0x1
 20c:	9fb5                	addw	a5,a5,a3
 20e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 212:	00074683          	lbu	a3,0(a4)
 216:	fd06879b          	addiw	a5,a3,-48
 21a:	0ff7f793          	zext.b	a5,a5
 21e:	fef671e3          	bgeu	a2,a5,200 <atoi+0x1c>
  return n;
}
 222:	6422                	ld	s0,8(sp)
 224:	0141                	addi	sp,sp,16
 226:	8082                	ret
  n = 0;
 228:	4501                	li	a0,0
 22a:	bfe5                	j	222 <atoi+0x3e>

000000000000022c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 22c:	1141                	addi	sp,sp,-16
 22e:	e422                	sd	s0,8(sp)
 230:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 232:	02b57463          	bgeu	a0,a1,25a <memmove+0x2e>
    while(n-- > 0)
 236:	00c05f63          	blez	a2,254 <memmove+0x28>
 23a:	1602                	slli	a2,a2,0x20
 23c:	9201                	srli	a2,a2,0x20
 23e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 242:	872a                	mv	a4,a0
      *dst++ = *src++;
 244:	0585                	addi	a1,a1,1
 246:	0705                	addi	a4,a4,1
 248:	fff5c683          	lbu	a3,-1(a1)
 24c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 250:	fee79ae3          	bne	a5,a4,244 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret
    dst += n;
 25a:	00c50733          	add	a4,a0,a2
    src += n;
 25e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 260:	fec05ae3          	blez	a2,254 <memmove+0x28>
 264:	fff6079b          	addiw	a5,a2,-1
 268:	1782                	slli	a5,a5,0x20
 26a:	9381                	srli	a5,a5,0x20
 26c:	fff7c793          	not	a5,a5
 270:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 272:	15fd                	addi	a1,a1,-1
 274:	177d                	addi	a4,a4,-1
 276:	0005c683          	lbu	a3,0(a1)
 27a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 27e:	fee79ae3          	bne	a5,a4,272 <memmove+0x46>
 282:	bfc9                	j	254 <memmove+0x28>

0000000000000284 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 284:	1141                	addi	sp,sp,-16
 286:	e422                	sd	s0,8(sp)
 288:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 28a:	ca05                	beqz	a2,2ba <memcmp+0x36>
 28c:	fff6069b          	addiw	a3,a2,-1
 290:	1682                	slli	a3,a3,0x20
 292:	9281                	srli	a3,a3,0x20
 294:	0685                	addi	a3,a3,1
 296:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 298:	00054783          	lbu	a5,0(a0)
 29c:	0005c703          	lbu	a4,0(a1)
 2a0:	00e79863          	bne	a5,a4,2b0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2a4:	0505                	addi	a0,a0,1
    p2++;
 2a6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2a8:	fed518e3          	bne	a0,a3,298 <memcmp+0x14>
  }
  return 0;
 2ac:	4501                	li	a0,0
 2ae:	a019                	j	2b4 <memcmp+0x30>
      return *p1 - *p2;
 2b0:	40e7853b          	subw	a0,a5,a4
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret
  return 0;
 2ba:	4501                	li	a0,0
 2bc:	bfe5                	j	2b4 <memcmp+0x30>

00000000000002be <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2c6:	00000097          	auipc	ra,0x0
 2ca:	f66080e7          	jalr	-154(ra) # 22c <memmove>
}
 2ce:	60a2                	ld	ra,8(sp)
 2d0:	6402                	ld	s0,0(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret

00000000000002d6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2d6:	4885                	li	a7,1
 ecall
 2d8:	00000073          	ecall
 ret
 2dc:	8082                	ret

00000000000002de <exit>:
.global exit
exit:
 li a7, SYS_exit
 2de:	4889                	li	a7,2
 ecall
 2e0:	00000073          	ecall
 ret
 2e4:	8082                	ret

00000000000002e6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2e6:	488d                	li	a7,3
 ecall
 2e8:	00000073          	ecall
 ret
 2ec:	8082                	ret

00000000000002ee <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2ee:	4891                	li	a7,4
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <read>:
.global read
read:
 li a7, SYS_read
 2f6:	4895                	li	a7,5
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <write>:
.global write
write:
 li a7, SYS_write
 2fe:	48c1                	li	a7,16
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <close>:
.global close
close:
 li a7, SYS_close
 306:	48d5                	li	a7,21
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <kill>:
.global kill
kill:
 li a7, SYS_kill
 30e:	4899                	li	a7,6
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <exec>:
.global exec
exec:
 li a7, SYS_exec
 316:	489d                	li	a7,7
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <open>:
.global open
open:
 li a7, SYS_open
 31e:	48bd                	li	a7,15
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 326:	48c5                	li	a7,17
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 32e:	48c9                	li	a7,18
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 336:	48a1                	li	a7,8
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <link>:
.global link
link:
 li a7, SYS_link
 33e:	48cd                	li	a7,19
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 346:	48d1                	li	a7,20
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 34e:	48a5                	li	a7,9
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <dup>:
.global dup
dup:
 li a7, SYS_dup
 356:	48a9                	li	a7,10
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 35e:	48ad                	li	a7,11
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 366:	48b1                	li	a7,12
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 36e:	48b5                	li	a7,13
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 376:	48b9                	li	a7,14
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 37e:	1101                	addi	sp,sp,-32
 380:	ec06                	sd	ra,24(sp)
 382:	e822                	sd	s0,16(sp)
 384:	1000                	addi	s0,sp,32
 386:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 38a:	4605                	li	a2,1
 38c:	fef40593          	addi	a1,s0,-17
 390:	00000097          	auipc	ra,0x0
 394:	f6e080e7          	jalr	-146(ra) # 2fe <write>
}
 398:	60e2                	ld	ra,24(sp)
 39a:	6442                	ld	s0,16(sp)
 39c:	6105                	addi	sp,sp,32
 39e:	8082                	ret

00000000000003a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	7139                	addi	sp,sp,-64
 3a2:	fc06                	sd	ra,56(sp)
 3a4:	f822                	sd	s0,48(sp)
 3a6:	f426                	sd	s1,40(sp)
 3a8:	f04a                	sd	s2,32(sp)
 3aa:	ec4e                	sd	s3,24(sp)
 3ac:	0080                	addi	s0,sp,64
 3ae:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b0:	c299                	beqz	a3,3b6 <printint+0x16>
 3b2:	0805c963          	bltz	a1,444 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3b6:	2581                	sext.w	a1,a1
  neg = 0;
 3b8:	4881                	li	a7,0
 3ba:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3be:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3c0:	2601                	sext.w	a2,a2
 3c2:	00000517          	auipc	a0,0x0
 3c6:	4de50513          	addi	a0,a0,1246 # 8a0 <digits>
 3ca:	883a                	mv	a6,a4
 3cc:	2705                	addiw	a4,a4,1
 3ce:	02c5f7bb          	remuw	a5,a1,a2
 3d2:	1782                	slli	a5,a5,0x20
 3d4:	9381                	srli	a5,a5,0x20
 3d6:	97aa                	add	a5,a5,a0
 3d8:	0007c783          	lbu	a5,0(a5)
 3dc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3e0:	0005879b          	sext.w	a5,a1
 3e4:	02c5d5bb          	divuw	a1,a1,a2
 3e8:	0685                	addi	a3,a3,1
 3ea:	fec7f0e3          	bgeu	a5,a2,3ca <printint+0x2a>
  if(neg)
 3ee:	00088c63          	beqz	a7,406 <printint+0x66>
    buf[i++] = '-';
 3f2:	fd070793          	addi	a5,a4,-48
 3f6:	00878733          	add	a4,a5,s0
 3fa:	02d00793          	li	a5,45
 3fe:	fef70823          	sb	a5,-16(a4)
 402:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 406:	02e05863          	blez	a4,436 <printint+0x96>
 40a:	fc040793          	addi	a5,s0,-64
 40e:	00e78933          	add	s2,a5,a4
 412:	fff78993          	addi	s3,a5,-1
 416:	99ba                	add	s3,s3,a4
 418:	377d                	addiw	a4,a4,-1
 41a:	1702                	slli	a4,a4,0x20
 41c:	9301                	srli	a4,a4,0x20
 41e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 422:	fff94583          	lbu	a1,-1(s2)
 426:	8526                	mv	a0,s1
 428:	00000097          	auipc	ra,0x0
 42c:	f56080e7          	jalr	-170(ra) # 37e <putc>
  while(--i >= 0)
 430:	197d                	addi	s2,s2,-1
 432:	ff3918e3          	bne	s2,s3,422 <printint+0x82>
}
 436:	70e2                	ld	ra,56(sp)
 438:	7442                	ld	s0,48(sp)
 43a:	74a2                	ld	s1,40(sp)
 43c:	7902                	ld	s2,32(sp)
 43e:	69e2                	ld	s3,24(sp)
 440:	6121                	addi	sp,sp,64
 442:	8082                	ret
    x = -xx;
 444:	40b005bb          	negw	a1,a1
    neg = 1;
 448:	4885                	li	a7,1
    x = -xx;
 44a:	bf85                	j	3ba <printint+0x1a>

000000000000044c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 44c:	7119                	addi	sp,sp,-128
 44e:	fc86                	sd	ra,120(sp)
 450:	f8a2                	sd	s0,112(sp)
 452:	f4a6                	sd	s1,104(sp)
 454:	f0ca                	sd	s2,96(sp)
 456:	ecce                	sd	s3,88(sp)
 458:	e8d2                	sd	s4,80(sp)
 45a:	e4d6                	sd	s5,72(sp)
 45c:	e0da                	sd	s6,64(sp)
 45e:	fc5e                	sd	s7,56(sp)
 460:	f862                	sd	s8,48(sp)
 462:	f466                	sd	s9,40(sp)
 464:	f06a                	sd	s10,32(sp)
 466:	ec6e                	sd	s11,24(sp)
 468:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 46a:	0005c903          	lbu	s2,0(a1)
 46e:	18090f63          	beqz	s2,60c <vprintf+0x1c0>
 472:	8aaa                	mv	s5,a0
 474:	8b32                	mv	s6,a2
 476:	00158493          	addi	s1,a1,1
  state = 0;
 47a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 47c:	02500a13          	li	s4,37
 480:	4c55                	li	s8,21
 482:	00000c97          	auipc	s9,0x0
 486:	3c6c8c93          	addi	s9,s9,966 # 848 <malloc+0x138>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 48a:	02800d93          	li	s11,40
  putc(fd, 'x');
 48e:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 490:	00000b97          	auipc	s7,0x0
 494:	410b8b93          	addi	s7,s7,1040 # 8a0 <digits>
 498:	a839                	j	4b6 <vprintf+0x6a>
        putc(fd, c);
 49a:	85ca                	mv	a1,s2
 49c:	8556                	mv	a0,s5
 49e:	00000097          	auipc	ra,0x0
 4a2:	ee0080e7          	jalr	-288(ra) # 37e <putc>
 4a6:	a019                	j	4ac <vprintf+0x60>
    } else if(state == '%'){
 4a8:	01498d63          	beq	s3,s4,4c2 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 4ac:	0485                	addi	s1,s1,1
 4ae:	fff4c903          	lbu	s2,-1(s1)
 4b2:	14090d63          	beqz	s2,60c <vprintf+0x1c0>
    if(state == 0){
 4b6:	fe0999e3          	bnez	s3,4a8 <vprintf+0x5c>
      if(c == '%'){
 4ba:	ff4910e3          	bne	s2,s4,49a <vprintf+0x4e>
        state = '%';
 4be:	89d2                	mv	s3,s4
 4c0:	b7f5                	j	4ac <vprintf+0x60>
      if(c == 'd'){
 4c2:	11490c63          	beq	s2,s4,5da <vprintf+0x18e>
 4c6:	f9d9079b          	addiw	a5,s2,-99
 4ca:	0ff7f793          	zext.b	a5,a5
 4ce:	10fc6e63          	bltu	s8,a5,5ea <vprintf+0x19e>
 4d2:	f9d9079b          	addiw	a5,s2,-99
 4d6:	0ff7f713          	zext.b	a4,a5
 4da:	10ec6863          	bltu	s8,a4,5ea <vprintf+0x19e>
 4de:	00271793          	slli	a5,a4,0x2
 4e2:	97e6                	add	a5,a5,s9
 4e4:	439c                	lw	a5,0(a5)
 4e6:	97e6                	add	a5,a5,s9
 4e8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4ea:	008b0913          	addi	s2,s6,8
 4ee:	4685                	li	a3,1
 4f0:	4629                	li	a2,10
 4f2:	000b2583          	lw	a1,0(s6)
 4f6:	8556                	mv	a0,s5
 4f8:	00000097          	auipc	ra,0x0
 4fc:	ea8080e7          	jalr	-344(ra) # 3a0 <printint>
 500:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 502:	4981                	li	s3,0
 504:	b765                	j	4ac <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 506:	008b0913          	addi	s2,s6,8
 50a:	4681                	li	a3,0
 50c:	4629                	li	a2,10
 50e:	000b2583          	lw	a1,0(s6)
 512:	8556                	mv	a0,s5
 514:	00000097          	auipc	ra,0x0
 518:	e8c080e7          	jalr	-372(ra) # 3a0 <printint>
 51c:	8b4a                	mv	s6,s2
      state = 0;
 51e:	4981                	li	s3,0
 520:	b771                	j	4ac <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 522:	008b0913          	addi	s2,s6,8
 526:	4681                	li	a3,0
 528:	866a                	mv	a2,s10
 52a:	000b2583          	lw	a1,0(s6)
 52e:	8556                	mv	a0,s5
 530:	00000097          	auipc	ra,0x0
 534:	e70080e7          	jalr	-400(ra) # 3a0 <printint>
 538:	8b4a                	mv	s6,s2
      state = 0;
 53a:	4981                	li	s3,0
 53c:	bf85                	j	4ac <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 53e:	008b0793          	addi	a5,s6,8
 542:	f8f43423          	sd	a5,-120(s0)
 546:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 54a:	03000593          	li	a1,48
 54e:	8556                	mv	a0,s5
 550:	00000097          	auipc	ra,0x0
 554:	e2e080e7          	jalr	-466(ra) # 37e <putc>
  putc(fd, 'x');
 558:	07800593          	li	a1,120
 55c:	8556                	mv	a0,s5
 55e:	00000097          	auipc	ra,0x0
 562:	e20080e7          	jalr	-480(ra) # 37e <putc>
 566:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 568:	03c9d793          	srli	a5,s3,0x3c
 56c:	97de                	add	a5,a5,s7
 56e:	0007c583          	lbu	a1,0(a5)
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	e0a080e7          	jalr	-502(ra) # 37e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 57c:	0992                	slli	s3,s3,0x4
 57e:	397d                	addiw	s2,s2,-1
 580:	fe0914e3          	bnez	s2,568 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 584:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 588:	4981                	li	s3,0
 58a:	b70d                	j	4ac <vprintf+0x60>
        s = va_arg(ap, char*);
 58c:	008b0913          	addi	s2,s6,8
 590:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 594:	02098163          	beqz	s3,5b6 <vprintf+0x16a>
        while(*s != 0){
 598:	0009c583          	lbu	a1,0(s3)
 59c:	c5ad                	beqz	a1,606 <vprintf+0x1ba>
          putc(fd, *s);
 59e:	8556                	mv	a0,s5
 5a0:	00000097          	auipc	ra,0x0
 5a4:	dde080e7          	jalr	-546(ra) # 37e <putc>
          s++;
 5a8:	0985                	addi	s3,s3,1
        while(*s != 0){
 5aa:	0009c583          	lbu	a1,0(s3)
 5ae:	f9e5                	bnez	a1,59e <vprintf+0x152>
        s = va_arg(ap, char*);
 5b0:	8b4a                	mv	s6,s2
      state = 0;
 5b2:	4981                	li	s3,0
 5b4:	bde5                	j	4ac <vprintf+0x60>
          s = "(null)";
 5b6:	00000997          	auipc	s3,0x0
 5ba:	28a98993          	addi	s3,s3,650 # 840 <malloc+0x130>
        while(*s != 0){
 5be:	85ee                	mv	a1,s11
 5c0:	bff9                	j	59e <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 5c2:	008b0913          	addi	s2,s6,8
 5c6:	000b4583          	lbu	a1,0(s6)
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	db2080e7          	jalr	-590(ra) # 37e <putc>
 5d4:	8b4a                	mv	s6,s2
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	bdd1                	j	4ac <vprintf+0x60>
        putc(fd, c);
 5da:	85d2                	mv	a1,s4
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	da0080e7          	jalr	-608(ra) # 37e <putc>
      state = 0;
 5e6:	4981                	li	s3,0
 5e8:	b5d1                	j	4ac <vprintf+0x60>
        putc(fd, '%');
 5ea:	85d2                	mv	a1,s4
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	d90080e7          	jalr	-624(ra) # 37e <putc>
        putc(fd, c);
 5f6:	85ca                	mv	a1,s2
 5f8:	8556                	mv	a0,s5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	d84080e7          	jalr	-636(ra) # 37e <putc>
      state = 0;
 602:	4981                	li	s3,0
 604:	b565                	j	4ac <vprintf+0x60>
        s = va_arg(ap, char*);
 606:	8b4a                	mv	s6,s2
      state = 0;
 608:	4981                	li	s3,0
 60a:	b54d                	j	4ac <vprintf+0x60>
    }
  }
}
 60c:	70e6                	ld	ra,120(sp)
 60e:	7446                	ld	s0,112(sp)
 610:	74a6                	ld	s1,104(sp)
 612:	7906                	ld	s2,96(sp)
 614:	69e6                	ld	s3,88(sp)
 616:	6a46                	ld	s4,80(sp)
 618:	6aa6                	ld	s5,72(sp)
 61a:	6b06                	ld	s6,64(sp)
 61c:	7be2                	ld	s7,56(sp)
 61e:	7c42                	ld	s8,48(sp)
 620:	7ca2                	ld	s9,40(sp)
 622:	7d02                	ld	s10,32(sp)
 624:	6de2                	ld	s11,24(sp)
 626:	6109                	addi	sp,sp,128
 628:	8082                	ret

000000000000062a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 62a:	715d                	addi	sp,sp,-80
 62c:	ec06                	sd	ra,24(sp)
 62e:	e822                	sd	s0,16(sp)
 630:	1000                	addi	s0,sp,32
 632:	e010                	sd	a2,0(s0)
 634:	e414                	sd	a3,8(s0)
 636:	e818                	sd	a4,16(s0)
 638:	ec1c                	sd	a5,24(s0)
 63a:	03043023          	sd	a6,32(s0)
 63e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 642:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 646:	8622                	mv	a2,s0
 648:	00000097          	auipc	ra,0x0
 64c:	e04080e7          	jalr	-508(ra) # 44c <vprintf>
}
 650:	60e2                	ld	ra,24(sp)
 652:	6442                	ld	s0,16(sp)
 654:	6161                	addi	sp,sp,80
 656:	8082                	ret

0000000000000658 <printf>:

void
printf(const char *fmt, ...)
{
 658:	711d                	addi	sp,sp,-96
 65a:	ec06                	sd	ra,24(sp)
 65c:	e822                	sd	s0,16(sp)
 65e:	1000                	addi	s0,sp,32
 660:	e40c                	sd	a1,8(s0)
 662:	e810                	sd	a2,16(s0)
 664:	ec14                	sd	a3,24(s0)
 666:	f018                	sd	a4,32(s0)
 668:	f41c                	sd	a5,40(s0)
 66a:	03043823          	sd	a6,48(s0)
 66e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 672:	00840613          	addi	a2,s0,8
 676:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 67a:	85aa                	mv	a1,a0
 67c:	4505                	li	a0,1
 67e:	00000097          	auipc	ra,0x0
 682:	dce080e7          	jalr	-562(ra) # 44c <vprintf>
}
 686:	60e2                	ld	ra,24(sp)
 688:	6442                	ld	s0,16(sp)
 68a:	6125                	addi	sp,sp,96
 68c:	8082                	ret

000000000000068e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 68e:	1141                	addi	sp,sp,-16
 690:	e422                	sd	s0,8(sp)
 692:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 694:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 698:	00001797          	auipc	a5,0x1
 69c:	9687b783          	ld	a5,-1688(a5) # 1000 <freep>
 6a0:	a02d                	j	6ca <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6a2:	4618                	lw	a4,8(a2)
 6a4:	9f2d                	addw	a4,a4,a1
 6a6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6aa:	6398                	ld	a4,0(a5)
 6ac:	6310                	ld	a2,0(a4)
 6ae:	a83d                	j	6ec <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6b0:	ff852703          	lw	a4,-8(a0)
 6b4:	9f31                	addw	a4,a4,a2
 6b6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6b8:	ff053683          	ld	a3,-16(a0)
 6bc:	a091                	j	700 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6be:	6398                	ld	a4,0(a5)
 6c0:	00e7e463          	bltu	a5,a4,6c8 <free+0x3a>
 6c4:	00e6ea63          	bltu	a3,a4,6d8 <free+0x4a>
{
 6c8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ca:	fed7fae3          	bgeu	a5,a3,6be <free+0x30>
 6ce:	6398                	ld	a4,0(a5)
 6d0:	00e6e463          	bltu	a3,a4,6d8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d4:	fee7eae3          	bltu	a5,a4,6c8 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 6d8:	ff852583          	lw	a1,-8(a0)
 6dc:	6390                	ld	a2,0(a5)
 6de:	02059813          	slli	a6,a1,0x20
 6e2:	01c85713          	srli	a4,a6,0x1c
 6e6:	9736                	add	a4,a4,a3
 6e8:	fae60de3          	beq	a2,a4,6a2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 6ec:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6f0:	4790                	lw	a2,8(a5)
 6f2:	02061593          	slli	a1,a2,0x20
 6f6:	01c5d713          	srli	a4,a1,0x1c
 6fa:	973e                	add	a4,a4,a5
 6fc:	fae68ae3          	beq	a3,a4,6b0 <free+0x22>
    p->s.ptr = bp->s.ptr;
 700:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 702:	00001717          	auipc	a4,0x1
 706:	8ef73f23          	sd	a5,-1794(a4) # 1000 <freep>
}
 70a:	6422                	ld	s0,8(sp)
 70c:	0141                	addi	sp,sp,16
 70e:	8082                	ret

0000000000000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	7139                	addi	sp,sp,-64
 712:	fc06                	sd	ra,56(sp)
 714:	f822                	sd	s0,48(sp)
 716:	f426                	sd	s1,40(sp)
 718:	f04a                	sd	s2,32(sp)
 71a:	ec4e                	sd	s3,24(sp)
 71c:	e852                	sd	s4,16(sp)
 71e:	e456                	sd	s5,8(sp)
 720:	e05a                	sd	s6,0(sp)
 722:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 724:	02051493          	slli	s1,a0,0x20
 728:	9081                	srli	s1,s1,0x20
 72a:	04bd                	addi	s1,s1,15
 72c:	8091                	srli	s1,s1,0x4
 72e:	0014899b          	addiw	s3,s1,1
 732:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 734:	00001517          	auipc	a0,0x1
 738:	8cc53503          	ld	a0,-1844(a0) # 1000 <freep>
 73c:	c515                	beqz	a0,768 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 73e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 740:	4798                	lw	a4,8(a5)
 742:	02977f63          	bgeu	a4,s1,780 <malloc+0x70>
 746:	8a4e                	mv	s4,s3
 748:	0009871b          	sext.w	a4,s3
 74c:	6685                	lui	a3,0x1
 74e:	00d77363          	bgeu	a4,a3,754 <malloc+0x44>
 752:	6a05                	lui	s4,0x1
 754:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 758:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 75c:	00001917          	auipc	s2,0x1
 760:	8a490913          	addi	s2,s2,-1884 # 1000 <freep>
  if(p == (char*)-1)
 764:	5afd                	li	s5,-1
 766:	a895                	j	7da <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 768:	00001797          	auipc	a5,0x1
 76c:	8a878793          	addi	a5,a5,-1880 # 1010 <base>
 770:	00001717          	auipc	a4,0x1
 774:	88f73823          	sd	a5,-1904(a4) # 1000 <freep>
 778:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 77a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 77e:	b7e1                	j	746 <malloc+0x36>
      if(p->s.size == nunits)
 780:	02e48c63          	beq	s1,a4,7b8 <malloc+0xa8>
        p->s.size -= nunits;
 784:	4137073b          	subw	a4,a4,s3
 788:	c798                	sw	a4,8(a5)
        p += p->s.size;
 78a:	02071693          	slli	a3,a4,0x20
 78e:	01c6d713          	srli	a4,a3,0x1c
 792:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 794:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 798:	00001717          	auipc	a4,0x1
 79c:	86a73423          	sd	a0,-1944(a4) # 1000 <freep>
      return (void*)(p + 1);
 7a0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7a4:	70e2                	ld	ra,56(sp)
 7a6:	7442                	ld	s0,48(sp)
 7a8:	74a2                	ld	s1,40(sp)
 7aa:	7902                	ld	s2,32(sp)
 7ac:	69e2                	ld	s3,24(sp)
 7ae:	6a42                	ld	s4,16(sp)
 7b0:	6aa2                	ld	s5,8(sp)
 7b2:	6b02                	ld	s6,0(sp)
 7b4:	6121                	addi	sp,sp,64
 7b6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7b8:	6398                	ld	a4,0(a5)
 7ba:	e118                	sd	a4,0(a0)
 7bc:	bff1                	j	798 <malloc+0x88>
  hp->s.size = nu;
 7be:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7c2:	0541                	addi	a0,a0,16
 7c4:	00000097          	auipc	ra,0x0
 7c8:	eca080e7          	jalr	-310(ra) # 68e <free>
  return freep;
 7cc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7d0:	d971                	beqz	a0,7a4 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7d4:	4798                	lw	a4,8(a5)
 7d6:	fa9775e3          	bgeu	a4,s1,780 <malloc+0x70>
    if(p == freep)
 7da:	00093703          	ld	a4,0(s2)
 7de:	853e                	mv	a0,a5
 7e0:	fef719e3          	bne	a4,a5,7d2 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 7e4:	8552                	mv	a0,s4
 7e6:	00000097          	auipc	ra,0x0
 7ea:	b80080e7          	jalr	-1152(ra) # 366 <sbrk>
  if(p == (char*)-1)
 7ee:	fd5518e3          	bne	a0,s5,7be <malloc+0xae>
        return 0;
 7f2:	4501                	li	a0,0
 7f4:	bf45                	j	7a4 <malloc+0x94>
